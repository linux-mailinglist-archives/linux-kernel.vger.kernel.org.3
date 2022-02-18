Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915C4BB5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiBRJcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:32:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiBRJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:32:45 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00A10FFA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:32:26 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220218093224epoutp048e59b587a8eb11be24b6fff66e114fe2~U14hHu-ho0057600576epoutp04y
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:32:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220218093224epoutp048e59b587a8eb11be24b6fff66e114fe2~U14hHu-ho0057600576epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645176744;
        bh=ZbMqDPz1/aU815nnZ0+dvC+64Od9cHIaosbZ+gukjNg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ufN5MbqAbZZAenR1zVZyugizY/WSTMNC6QMwHFHBVnFvwwEo8HHRqGEV8UGCuHcob
         KPg5w00SVfHt9WXhj9S+AC6pGxc8NfHAvSzk7ih97rjV4lyvGEgWN9R85sM7qMFA2L
         clHPsvTzLkDiXKHQgnfsMOsgybgG/4kotf/Lguew=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220218093223epcas1p4d6902da1601e1950ce086c9561c25aea~U14goH_9p1100611006epcas1p4p;
        Fri, 18 Feb 2022 09:32:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K0RLC42t7z4x9QJ; Fri, 18 Feb
        2022 09:32:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.3F.21932.3A76F026; Fri, 18 Feb 2022 18:32:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220218093218epcas1p385c5cca2010183e90ac7ac1b4063af25~U14b6Pt_72486024860epcas1p3j;
        Fri, 18 Feb 2022 09:32:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220218093218epsmtrp2d30138d4b8aae59d2103d3f9ef8448bb~U14b4tVkO0963709637epsmtrp2r;
        Fri, 18 Feb 2022 09:32:18 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-88-620f67a3e6c5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.82.29871.2A76F026; Fri, 18 Feb 2022 18:32:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220218093218epsmtip1476a8068f389cb2e242f97f10dcdec00~U14brLOBq2637126371epsmtip1u;
        Fri, 18 Feb 2022 09:32:18 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] extcon: add optional input-debounce attribute
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ef8bf06d-5762-8149-802a-de5cbdc11cc9@samsung.com>
Date:   Fri, 18 Feb 2022 18:56:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220204135937.GA1166088@francesco-nb.int.toradex.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmvu7idP4kg0lTZSzW9h5lsZh/5Byr
        xd2lPxktLu+aw2ax9PpFJovbjSvYLL61P2K1aN17hN2Bw2PNvDWMHrPun2Xz2LSqk82jb8sq
        Ro9Nrzw8Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdsfrDa7aCFxwV9z/tYm9gbGPvYuTgkBAwkXgxV6GLkYtDSGAHo8Sho2tY
        IJxPjBLr/z1jh3C+MUq8u/eBqYuRE6zj8KNDrBCJvYwSh2f+gqp6zyjRfvEiG0iVsICnxJMX
        +8E6RAQKJV72TQWzmQVuMko8uKwOYrMJaEnsf3EDrJ5fQFHi6o/HjCA2r4CdxPwlH1lAbBYB
        VYkpB16ygtiiAmESJ7e1QNUISpyc+QSshlPAReL9uuUsEPPFJW49mQ+1S16ieetsZpDjJARW
        ckjM3j2RHeIFF4muO0+hbGGJV8e3QNlSEp/f7WWDaGhmlGh4cZsRwulhlDj6rI8FospYYv/S
        yUyg4GMW0JRYv0sfIqwosfP3XEaIzXwS7772sEJCmFeio00IokRZ4vKDu9BglJRY3N7JNoFR
        aRaSf2Yh+WEWkh9mISxbwMiyilEstaA4Nz212LDABB7dyfm5mxjBiVXLYgfj3Lcf9A4xMnEw
        HmKU4GBWEuH9cJA3SYg3JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbnA1N7Xkm8oYmlgYmZkbGJ
        haGZoZI4b+/U04lCAumJJanZqakFqUUwfUwcnFINTO4VU1KElx611CpwvCUVu2S6jsLulxum
        zy/XCFuj8Jz7yhE/pwwzox0XQlYWL9mTkLikesGhXZMublpuY9ts2HNgifDzxKkbFh5neLV3
        +wb9OI57vSU8+heEHT3kRJ5HqAve9jDsmmcz45ZZ+P69zzcvWSmQwf877ui2yT2q71RvnJ1e
        VDj9sOsf/pmLGtI2cdZx/MydcuFtRbHlP/kL+TN6Uudvmi66LzjgLIvIxwxbhm8Lmi9/fqV0
        tc5nYZbYkub0bqZ9HAvcZ1kWsXzv1Ipc0j7hzb24hUmygpIsq2Wnz5CNfFl6qq5fb+6M2MKd
        Gw+2f7hwq/eHzdm7C16Vblf9OP3E7zwZXgsz5uzkX3ZKLMUZiYZazEXFiQDKRVxsNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTndROn+Swc4GWYu1vUdZLOYfOcdq
        cXfpT0aLy7vmsFksvX6RyeJ24wo2i2/tj1gtWvceYXfg8Fgzbw2jx6z7Z9k8Nq3qZPPo27KK
        0WPTKw+Pz5vkAtiiuGxSUnMyy1KL9O0SuDJWf3jNVvCCo+L+p13sDYxt7F2MnBwSAiYShx8d
        Yu1i5OIQEtjNKDHh+G2ohKTEtItHmbsYOYBsYYnDh4shat4ySkw8ugKsRljAU+LJi/1MIDUi
        AoUSLzeGgtQwC9xklFi27xYbRMMRJonWuwcYQRrYBLQk9r+4wQZi8wsoSlz98RgszitgJzF/
        yUcWEJtFQFViyoGXrCC2qECYxM4lj5kgagQlTs58AlbDKeAi8X7dcjCbWUBd4s+8S8wQtrjE
        rSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1ya
        l66XnJ+7iREcYVqaOxi3r/qgd4iRiYPxEKMEB7OSCO+Hg7xJQrwpiZVVqUX58UWlOanFhxil
        OViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAda5GVuym02uz+6cMH9oj4mn4281dUzUt9
        cFWUWfDAZOWzzCb3+eb6SJ25sPrupiuCW9cEJWd0bPDMUA2++8yOWdL6dF3xWobMI7p7Wxfc
        n3nQekHs0aVt9rNidlnybnr9tDUnWzco/kXFowaxOZZ1WSs/2fxqZd8V3L/W1mVVFqdM9kT9
        T/5u4le0N1ioy1e+nKRxSn/tEV6nt13tyyuLn8nVmF+M/L7gdv/lxC8r4s1OqW1getVb6vF5
        huKb0Bv24gekdLdd733veK1Dgv3opf2zQtfuTZ38PPvAfqOHesd5Tdkjs/u/NB/nZld1YH7J
        /t81xkYn+MZWGaF1k1s/hTxjPci38OkJw/8aVwWUWIozEg21mIuKEwFdaRAMHwMAAA==
X-CMS-MailID: 20220218093218epcas1p385c5cca2010183e90ac7ac1b4063af25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20171019095315epcas1p1da40aef7397c561c5fe970309a97b762
References: <1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com>
        <CGME20171019095315epcas1p1da40aef7397c561c5fe970309a97b762@epcas1p1.samsung.com>
        <1508406773-887-2-git-send-email-raveendra.padasalagi@broadcom.com>
        <59E87BDB.2090104@samsung.com>
        <20220204135937.GA1166088@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On 2/4/22 10:59 PM, Francesco Dolcini wrote:
> Hello Raveendra, Chanwoo et all
> 
> On Thu, Oct 19, 2017 at 07:18:03PM +0900, Chanwoo Choi wrote:
>> On 2017년 10월 19일 18:52, Raveendra Padasalagi wrote:
>>> Add changes to capture optional dt attribute "input-debounce"
>>> provided in extcon node and used the same value if provided otherwise
>>> default value of 20000 usecs is used for id and vbus gpios debounce time.
>> Looks good to me.
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> After completing the review of patch1 from DT maintainer,
>> I'll merge these patch sets.
> 
> I noticed that this series [1] was never merged in the end, anything I
> can do to help?
> It is solving a real issue and I would be glad to understand what's the
> reason this was not merged in 2017 to get it done now.
> 
> Francesco
> 
> [1] https://lore.kernel.org/all/1508406773-887-1-git-send-email-raveendra.padasalagi@broadcom.com/
> 
> 

Need to receive the review from dt maintainer.
If possible, resend this patchset.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
