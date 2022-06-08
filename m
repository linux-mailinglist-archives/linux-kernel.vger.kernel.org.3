Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55B542316
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiFHFFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiFHFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:04:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20F21C625
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:00:45 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220608020040epoutp028e8e6f54b480c394993354a7aa569f19~2grhBV5T51489514895epoutp023
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220608020040epoutp028e8e6f54b480c394993354a7aa569f19~2grhBV5T51489514895epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654653641;
        bh=NesFd0hFZnDgwRVoNRjbk3wCcwYkZt4oYwHdgKFII7g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n3E1QaWMyUDszrtrTSihdU6ijl78MfjHiYaFN2GPTcuziyIXHH6SuDofwE2pUbGFN
         nB4GLosgo/ErTDg+++QrPjWNBBOe5r7JTCiwxjRvhb1jDGoCbm20Srdsra4knwwgK0
         6Lf6I7loWZynkK0lDhAYg3FCHuVauPwmbINMFqgc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220608020040epcas1p3ac4a4f86f80302d0d910061cfa14fc9f~2grgh0AXD1369813698epcas1p3Y;
        Wed,  8 Jun 2022 02:00:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LHr6G5lhlz4x9Q1; Wed,  8 Jun
        2022 02:00:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.FD.09935.6C200A26; Wed,  8 Jun 2022 11:00:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220608020038epcas1p29d690189e5f4ec195a410e721da9c959~2greoE3K_3197331973epcas1p2D;
        Wed,  8 Jun 2022 02:00:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220608020038epsmtrp1c4e2d10c9664c0259ec2f933dc5552ee~2grenPE1-1419514195epsmtrp1o;
        Wed,  8 Jun 2022 02:00:38 +0000 (GMT)
X-AuditID: b6c32a39-f37ff700000026cf-a0-62a002c6a183
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.F5.11276.6C200A26; Wed,  8 Jun 2022 11:00:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220608020037epsmtip185ff608915ef81f4d9c3c6281c3cc037~2greO7RWm2414924149epsmtip1x;
        Wed,  8 Jun 2022 02:00:37 +0000 (GMT)
Subject: Re: [PATCH v7 0/2] Introduce MediaTek CCI devfreq driver
To:     Johnson Wang <johnson.wang@mediatek.com>, krzk+dt@kernel.org,
        robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1f3bb9cd-dd13-c9fb-9d90-a02159a59463@samsung.com>
Date:   Wed, 8 Jun 2022 11:00:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220607140556.6278-1-johnson.wang@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmvu4xpgVJBjf69CzmHznHavHsViOb
        xfH9S9gtjv0Ktni6+TGTxctZ99gszja9YbfY9Pgaq8XlXXPYLC43X2S0+Nx7hNHi07oOFovW
        vUfYHXg9Nq3qZPPYvKTeo+XkfhaPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ1x+XVMQYNoxYY7axgbGNcLdDFyckgI
        mEhsmfOEtYuRi0NIYAejROvJ6SwQzidGifblh6Ey3xgl3n5fyQ7Tsvz3X2aIxF5Gibs3DkA5
        7xkl/nduYASpEhZwlLj5fworiC0iUChx/+40dpAiZoF5TBKnz61kAkmwCWhJ7H9xgw3E5hdQ
        lLj64zFYM6+AncTvtafBbBYBFYm+rTvBVosKhEmc3NYCVSMocXLmExYQmxOo/sPKVrBlzALi
        EreezGeCsOUltr+dA3adhMABDomvr1ugfnCRmHf2AiuELSzx6vgWqLiUxMv+NnaIhmZGiYYX
        txkhnB5GiaPP+lggqowl9i+dDLSCA2iFpsT6XfoQYUWJnb/nMkJs5pN497WHFaREQoBXoqNN
        CKJEWeLyg7tMELakxOL2TrYJjEqzkPwzC8kPs5D8MAth2QJGllWMYqkFxbnpqcWGBabw+E7O
        z93ECE7AWpY7GKe//aB3iJGJg/EQowQHs5IIr2T4/CQh3pTEyqrUovz4otKc1OJDjKbAEJ7I
        LCWanA/MAXkl8YYmlgYmZkbGJhaGZoZK4ryrpp1OFBJITyxJzU5NLUgtgulj4uCUamBK2fGu
        r+3DffnrqSdeFU4sylz8IM6wb/X2M3GX/VlqvznsZI9aunm67Y7Y018KInnueSayaDeWc/1/
        knY507Y6+RLPnU9pmwpv/EnhK5Vs539x8/0x8/YuvhlFr+znP47orJnzpqZtu3f4iuyHys5G
        f9WdRTYw/38XGl+4enL7kQ1rN+x5Zt9wtjhLROFb4wPemFQ5kWOOkU/vfFn1NZFxvdv75iUx
        N3QVc0sZ+aetcrmcucZFXk+1gTdpm05aRmx/2izfz4HX7q1ed1Ly5N6XZvnOlrP/W66oldH+
        UDtp19++lSxN8VNygkWm82fvPLXmzL8jF9dcfN3zr/HLEvnt+6UWN9spPdqrFORxcIKcEktx
        RqKhFnNRcSIA4ObkXkkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnO4xpgVJBh8f8FvMP3KO1eLZrUY2
        i+P7l7BbHPsVbPF082Mmi5ez7rFZnG16w26x6fE1VovLu+awWVxuvsho8bn3CKPFp3UdLBat
        e4+wO/B6bFrVyeaxeUm9R8vJ/SwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXH5dUxBg2jF
        hjtrGBsY1wt0MXJySAiYSCz//Ze5i5GLQ0hgN6PE+7+zmCASkhLTLh4FSnAA2cIShw8XQ9S8
        ZZT4fLWBHaRGWMBR4ub/KawgtohAocT59w/BbGaBOUwSn/fxQzRMZJSYfXMB2FA2AS2J/S9u
        sIHY/AKKEld/PGYEsXkF7CR+rz0NZrMIqEj0bd0JtkBUIExi55LHTBA1ghInZz5hAbE5geo/
        rGyFWqYu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCYl1quV5yYW1yal66XnJ+7iREchVqaOxi3r/qgd4iRiYPxEKMEB7OSCK9k+PwkId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpj4C9gO3a8xiX+1
        b09YAzdPzuX+l20Be/bNXmLaFhpTOP3xTr4zLqekOJOCvEqCNlxc1mKV+XftNBv7LJ3gkDLr
        FUy/3vx0flGVM1sp4yLTuVuPF5v72DlsubxIzUbs7P2evRyz2FPka6fKPFK07xE4MHW56eYS
        Y/vvcTMrH/sYzeusq0x+wRH885yq1i/pa+WaLw9Ouy55f/4Vi0b+xr1vNh/bd+eKup5C4WW1
        fS4RH39NF3ATun8vMy1ETGD+y/L4924z3nyUOP2r/+Xadt+3Lx7abTj56wCvTphe7Vq1m+68
        W74n7P2+iW9TulJ7ZscbrqIfjXUT9s2WK7X9r6VvM13j66EwgYZzYZ/CpdKVWIozEg21mIuK
        EwEqd5peMQMAAA==
X-CMS-MailID: 20220608020038epcas1p29d690189e5f4ec195a410e721da9c959
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220607140711epcas1p1aca32de28831fae8a6fd3b890b26f7ac
References: <CGME20220607140711epcas1p1aca32de28831fae8a6fd3b890b26f7ac@epcas1p1.samsung.com>
        <20220607140556.6278-1-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 11:05 PM, Johnson Wang wrote:
> The Cache Coherent Interconnect (CCI) is the management of cache
> coherency by hardware. CCI DEVFREQ is DVFS driver for power saving by
> scaling clock frequency and supply voltage of CCI. CCI uses the same
> input clock source and power rail as LITTLE CPUs on Mediatek SoCs.
> 
> This series depends on:
> Chanwoo's repo: kernel/git/chanwoo/linux.git
> branch: devfreq-testing
> [1]: PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
> [2]: PM / devfreq: Add cpu based scaling support to passive governor
> [3]: PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
> [4]: PM / devfreq: passive: Update frequency when start governor
> 
> Changes in v7:
> - remove the 'ret' printing from dev_err_probe().
> 
> Changes in v6:
> - Remove unnecessary "goto" statement.
> 
> Changes in v5:
> - Modify some binding description.
> - Remove pre_voltage member.
> - Not to enable/disable intermediate clock.
> - Not to "put" resources that using devm_ variants.
> 
> Resend v4:
> - CC interconnect maintainer.
> - Change sign-off sequence in commit message.
> 
> Changes in v4:
> - Add a maintainer in the binding document.
> - Modify clock description.
> - Add binding document into MAINTAINERS.
> - Replace format specifier %d with %ld.
> 
> Changes in v3:
> - Move binding document to 'interconnect' and rename it.
> - Add COMPILE_TEST dependence symbol.
> - Remove need_voltage_tracking variable.
> - Move mtk_ccifreq_voltage_tracking() code into mtk_ccifreq_set_voltage().
> - Add an interation limit in the while() loop.
> - Replace 'cci_dev' with 'dev'
> - Replace old_* with pre_*
> - Remove of_match_ptr()
> - Use module_platform_driver()
> 
> Changes in v2:
> - Take MT8183 as example in binding document.
> - Use dev_err() instead of pr_err().
> - Use 'goto' statement to handle error case.
> - Clean up driver code.
> 
> Johnson Wang (2):
>   dt-bindings: interconnect: Add MediaTek CCI dt-bindings
>   PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver
> 
>  .../bindings/interconnect/mediatek,cci.yaml   | 140 ++++++
>  MAINTAINERS                                   |   1 +
>  drivers/devfreq/Kconfig                       |  10 +
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/mtk-cci-devfreq.c             | 474 ++++++++++++++++++
>  5 files changed, 626 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
