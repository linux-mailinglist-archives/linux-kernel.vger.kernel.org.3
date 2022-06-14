Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C2054A3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiFNBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349543AbiFNBxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:53:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE22FE5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:53:35 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220614015333epoutp019ef303426f03523645fe194a1b69cbac~4WdAqB2sA1716417164epoutp017
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220614015333epoutp019ef303426f03523645fe194a1b69cbac~4WdAqB2sA1716417164epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655171613;
        bh=KeUSMjPxfeYUdIbhLBS2PLBAv7X1Im7vE6VhOszweWo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GVW2RgfBU80c8ht8V6/sP+01Iih5EAkC8JA/K551Oq+/Gu0fIG7PoBI9TPjzVXU3g
         /bAbECKC2ZsBznXfKqGlUAF7xR+MFH5UYgj/IF0J0AXOap/e04AbCHsMNfC3dmeBLJ
         JZzW2yrDVfh6F53pchqlnFgOc26KcJ3eC8saf68I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220614015332epcas5p2d1a679e2aaf6c3b0d081dc1095213bfb~4Wc-yJ4Bw0766107661epcas5p22;
        Tue, 14 Jun 2022 01:53:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LMWgG543Xz4x9Q7; Tue, 14 Jun
        2022 01:53:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.19.10063.A1AE7A26; Tue, 14 Jun 2022 10:53:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220614015330epcas5p4edea89c5b19319fd7cef639649a5d98c~4Wc9fMOot0694306943epcas5p4N;
        Tue, 14 Jun 2022 01:53:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220614015330epsmtrp2363a3ce84e106b338a4a468a590a3015~4Wc9ebiGJ3187431874epsmtrp2i;
        Tue, 14 Jun 2022 01:53:30 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-25-62a7ea1a5447
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.10.08924.A1AE7A26; Tue, 14 Jun 2022 10:53:30 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220614015329epsmtip1e63aad1776fff85e89d8a740a029fb54~4Wc8Xif3Y1562015620epsmtip1o;
        Tue, 14 Jun 2022 01:53:28 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     "'kernel test robot'" <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com>
Subject: RE: [mkp-scsi:for-next 31/41]
 drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs' does
 not refer to any field in type 'const struct samsung_ufs_phy_drvdata'; did
 you mean 'cfg'?
Date:   Tue, 14 Jun 2022 07:23:27 +0530
Message-ID: <02b601d87f91$8bce05b0$a36a1110$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEQai/Pc/D7KWC/Dc1oiNsuf0vQXwHf6YGgAfopI8ICoiTpJa6qa8/A
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhq7Uq+VJBguuK1tce3mB3eLyfm2L
        s93XGC0u75rDZvGq+RGbxZMp+9kslh//x+TA7rF4z0smj+7Z/1g8Xmyeyejx8ektFo++LasY
        PT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhg
        YGQKVJiQnbFsyyT2giVcFQ+PH2JtYNzN0cXIySEhYCJx4X0DC4gtJLCbUeLdEfsuRi4g+xOj
        xNPXd5ggnM+MEtv/3mCB6Xj6cgIjRGIXo8SZj1/ZIZyXjBLrGqYxglSxCehK7FjcxgZiiwiY
        S0yccJQFpIhZ4BajxP/rr1lBEpwCxhIdUz6A7RAWuAy08PYMsB0sAqoSd89OByri4OAVsJQ4
        ud0eJMwrIChxcuYTsBJmAXmJ7W/nMEOcpCDx8+kyVohlbhJNEyayQdSIS7w8egTsOgmBpRwS
        j5a8BpspIeAiMeOUOkSvsMSr41vYIWwpic/v9rJBlHhILPojBRHOkHi7fD0jhG0vceDKHBaQ
        EmYBTYn1u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzuKjTcpCUmdnezwgx/fMl5AqPiLCRvzULy
        1iwk589C2LWAkWUVo2RqQXFuemqxaYFhXmo5PLaT83M3MYKTqZbnDsa7Dz7oHWJk4mA8xCjB
        wawkwjv54rIkId6UxMqq1KL8+KLSnNTiQ4ymwKCeyCwlmpwPTOd5JfGGJpYGJmZmZiaWxmaG
        SuK8Av8bk4QE0hNLUrNTUwtSi2D6mDg4pRqYzLe0nry5QWk+7w/B7/FK+Yp+2+xlGm8/uFe1
        dGbiX9EogRcHHtZFePRKCNkqKHCu77r+6NQDCZnuPZ1qi7wOxfefKb61xcp+/4YXKvPNvRd+
        M5JIqy0qT+GPsIic0viDR/HL58ozx13zXixTzMjI31/08cHXfSmzaybfEcvVajyz2o2ny0GA
        yf4pF6+cclDJuiB/i5ipUo92bbeTSjicNuOn+roCm9Dcx4cNd04z/pR6UciEae4OQ5cKx6N+
        NRcj3+yIWmOVGuml6Hix0H7N1hBHjqt3lP4z24mGZqnt629xWrT26d42j0Kl8C97Zt+elK1j
        90bnZPmXM7N4jGXFtsfar7Pa1jrNvKsrUVGJpTgj0VCLuag4EQAoh+OuLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTlfq1fIkgzk32C2uvbzAbnF5v7bF
        2e5rjBaXd81hs3jV/IjN4smU/WwWy4//Y3Jg91i85yWTR/fsfyweLzbPZPT4+PQWi0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlLNsyib1gCVfFw+OHWBsYd3N0MXJySAiYSDx9OYGxi5GL
        Q0hgB6PEnTknGSES0hLXN05gh7CFJVb+e84OUfScUWLGrLtsIAk2AV2JHYvbwGwRAXOJiROO
        soAUMQs8YJS40LscquMGo0TLuqlMIFWcAsYSHVM+MIEkhAXOMkrsuHuYBSTBIqAqcffsdNYu
        Rg4OXgFLiZPb7UHCvAKCEidnPmEBCTML6Em0bQS7jllAXmL72znMENcpSPx8uowV4gg3iaYJ
        E9kgasQlXh49wj6BUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxguNKS2sH455VH/QOMTJxMB5ilOBgVhLhnXxxWZIQb0piZVVqUX58UWlOavEhRmkO
        FiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTHMs4jaxPe45XJ4fw5e7/27Hh2tM0c/WT46I
        OtL/7+5MReVUFfYnNxdbS4gVL2u/586vEijdpTKZ2W2+qBzPQTMnT58be848fbC3nTOi6NGp
        7ZUv5t66vsv6w8RzRVZ1sx/fkyzx83nkuUapYHbQxcdBn3l8489MMOd9NMf8qzdf3MM9Lzva
        WTmldjb3/TSfFiB4Sa9OTtTbf5XAu/br/64/LdlR0bc1r3/O15XxvPuTmyLsnv69t96NTedf
        EH/igty9c+ekGIU92aK1+Mx887DLCeJ7k3ruL7e9pld/iOXFwbeuygq3plSHSs2SP9mQqewX
        Nje9WibpjbtmzxeOTomErfWfzVYefDaPb9kcASWW4oxEQy3mouJEACbwvjcaAwAA
X-CMS-MailID: 20220614015330epcas5p4edea89c5b19319fd7cef639649a5d98c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220611233355epcas5p1970bae9647eae17e20d330775b584695
References: <CGME20220611233355epcas5p1970bae9647eae17e20d330775b584695@epcas5p1.samsung.com>
        <202206120755.03gKC0ne-lkp@intel.com>
        <000001d87e12$c6962770$53c27650$@samsung.com>
        <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

>-----Original Message-----
>From: Martin K. Petersen [mailto:martin.petersen@oracle.com]
>Sent: Tuesday, June 14, 2022 7:15 AM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: 'kernel test robot' <lkp@intel.com>; llvm@lists.linux.dev; kbuild-
>all@lists.01.org; linux-kernel@vger.kernel.org; 'Martin K. Petersen'
><martin.petersen@oracle.com>; 'Chanho Park'
><chanho61.park@samsung.com>; 'Bharat Uppal'
><bharat.uppal@samsung.com>
>Subject: Re: [mkp-scsi:for-next 31/41] drivers/phy/samsung/phy-fsd-
>ufs.c:50:3: error: field designator 'cfgs' does not refer to any field in
type
>'const struct samsung_ufs_phy_drvdata'; did you mean 'cfg'?
>
>
>Alim,
>
>> I was expecting phy driver changes will go via phy tree, where [1] is
>> available.
>>
>> @Martin, can you please take a look?
>>
>> You can just take the ufs changes (along with its device tree) and
>> drop the phy change or take the [1] above.
>
>Doesn't matter to me, happy to drop the series again. I just queued it up
to
>see if there would be any warnings.
>
No need to drop entire series, as UFS changes has got all Reviewed-by tags.

Just drop patch-{1/6, 2/6 and 3/6} (phy changes)

And please keep patch-{4/6, 5/6 and 6/6} in your tree

Thanks 

>--
>Martin K. Petersen	Oracle Linux Engineering

