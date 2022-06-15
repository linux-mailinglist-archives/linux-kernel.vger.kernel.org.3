Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566954D558
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiFOXba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbiFOXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:31:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE70140DC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:31:25 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220615233124epoutp026c3577ec8c63f27115cb3f869f9c0f10~47zdsviTl0781607816epoutp028
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:31:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220615233124epoutp026c3577ec8c63f27115cb3f869f9c0f10~47zdsviTl0781607816epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655335884;
        bh=oBv8FzAUp/cn8TFUjbVFXThtO0fiAmUlx69xO+lEKCc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pKJtBznFNI/7F3W6DuH3s9dflVN+wyKJjRCLaEQHVc1DmHwxBzVrZO3pivxFXq/pj
         sxSoLUc95j7wXORjaff08hrVr+LUKxlXwU6ilHKuWTpzmP+VSFtIUomjS850dKkR6N
         92lryeeNS52ZGlBVzMk7xfT+Yw99lDQisLGB5LuQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220615233123epcas2p2f1953317984d901160c0652cc4cb06ae~47zdGtSC50212002120epcas2p2D;
        Wed, 15 Jun 2022 23:31:23 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LNhQM1VXyz4x9Q0; Wed, 15 Jun
        2022 23:31:23 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.68.09694.BCB6AA26; Thu, 16 Jun 2022 08:31:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220615233122epcas2p43646a7b07e34e14187dbecb15a6ac7c7~47zcE0HFt2589425894epcas2p4J;
        Wed, 15 Jun 2022 23:31:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615233122epsmtrp2858ee391ba68e7dda12d483e0becf724~47zcDvfxU1290312903epsmtrp2S;
        Wed, 15 Jun 2022 23:31:22 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-fe-62aa6bcbd754
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.DB.11276.ACB6AA26; Thu, 16 Jun 2022 08:31:22 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615233122epsmtip2639df4e24cf182e548dfe4e55c64ffe4~47zb5T2fe2583125831epsmtip2h;
        Wed, 15 Jun 2022 23:31:22 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <beanhuo@micron.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220615121204.16642-2-alim.akhtar@samsung.com>
Subject: RE: [PATCH 2/3] ufs: host: ufs-exynos: use already existing define
Date:   Thu, 16 Jun 2022 08:31:22 +0900
Message-ID: <000901d88110$05d8e530$118aaf90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvmU5DcyiwlSK20wvy0jCKBqg0HwHuD7sgAcDWRyutBXYMoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhe7p7FVJBgvOsFo8mLeNzeLlz6ts
        FgcfdrJYTPvwk9mi78VDZotNj6+xWlzeNYfNYsKqbywWM87vY7Lovr6DzWL58X9MDtwel694
        e9y5tofNY/OSeo/v6zvYPD4+vcXi0bdlFaPH501yHu0HupkCOKKybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfMevyHueAyU8X0+efZGxgn
        MnUxcnJICJhI7L17g62LkYtDSGAHo8THuz9ZIZxPjBKfl+5jgnC+MUpcP72ZDaalb9IxRojE
        XkaJW08nQPW/YJRoevGVBaSKTUBf4mXHNrBZIiCDP6/4xALiMAtsZJTobdwKVsUpYCvxfe0K
        RhBbWMBb4vDRdWBxFgFViat7ZzGD2LwClhIrVy9mgbAFJU7OfAJmMwvIS2x/O4cZ4iYFiZ9P
        l7GC2CICThJNR1YwQdSISMzubGMGWSwhcIZD4uHCvUC3cgA5LhJts9UheoUlXh3fwg5hS0l8
        frcX6s9iiaWzPjFB9DYwSlze9gsqYSwx61k7I8gcZgFNifW79CFGKkscuQV1Gp9Ex+G/7BBh
        XomONiGIRnWJA9uns0DYshLdcz6zTmBUmoXksVlIHpuF5IFZCLsWMLKsYhRLLSjOTU8tNiow
        gUd3cn7uJkZwItby2ME4++0HvUOMTByMhxglOJiVRHjNglcmCfGmJFZWpRblxxeV5qQWH2I0
        BQb1RGYp0eR8YC7IK4k3NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXA
        ZK9ld3rL841yrfMOBorxy2782GtVuaBd2+7Twv37+rZxrW5qOnTzzDv+lEt7rhqt0LY/WPp+
        9rWryyctVbiatlDt6vNNO+dFnOWduyXL7IPjo1SDHRWnTQImO5689sZhalB/mUpEStzPeTdb
        5gU7LuOYFPuB7+wX88CzDzbwXrZKj995p6VNf2LIjBSrPck/c9l3/+p8O7Vmjsusw3OcS96E
        SSjb8lY/L355XfaKE4PJAsmO6fx3qhb6n3i9YW5Pn/XluLL6jJL20CtnPbdx/Z2x4OHEJN3m
        9GNZa+/ufe+/bpJvxINFnToyfqtTZu44v1DRr5311YMlCuU/TqWfjhI8sSy9T2Lar8VmR6y5
        bqcosRRnJBpqMRcVJwIAF90H300EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO6p7FVJBm27lSwezNvGZvHy51U2
        i4MPO1kspn34yWzR9+Ihs8Wmx9dYLS7vmsNmMWHVNxaLGef3MVl0X9/BZrH8+D8mB26Py1e8
        Pe5c28PmsXlJvcf39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwBHFFcNimpOZllqUX6dglcGbMe
        /2EuuMxUMX3+efYGxolMXYycHBICJhJ9k44xdjFycQgJ7GaUaJu0mhUiISvx7N0OdghbWOJ+
        yxFWiKJnjBL3Xv1hA0mwCehLvOzYBpYQEdgD1D3vFDuIwyywnVFi4+ILLBAt+xklOpuvg7Vw
        CthKfF+7ghHEFhbwljh8dB0LiM0ioCpxde8sZhCbV8BSYuXqxSwQtqDEyZlPwGxmAW2Jpzef
        QtnyEtvfzmGGuE9B4ufTZWB3iwg4STQdWcEEUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCy
        rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5LLc0djNtXfdA7xMjEwXiIUYKDWUmE
        1yx4ZZIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTDo5
        jae79501XTtXc0Z5kmrzzenFEUqz/94Q7Av9E3hh13rDwwLLZyz9UfY5y9Y85O9zr72OUn/P
        6ixcO+nUfEPWHRpTswXXlqxQeVwTm740bFHfXrE/c868KD9wUvz/jIt3plTZF3HITEw56vzv
        eWBGecSbcK9dV1bwH7riX79iQu7n61OuiGWsNt/sEMqsosLHt9nc5OK2f6UrxG4ZvLw8IVdY
        q9b7BpNO1PvVCWeit/Ztlb5xpYY5MX7HWsOIcyoFm1t8gjPYtvZWTzw/0bT7n8+hnR3PNmxZ
        9iGr0DHg+Y5VOfXc7SlBomurAmY5i97MLD0T6xyqf2WCyKJLM4WibxhYVm/70/ReXOFLeZES
        S3FGoqEWc1FxIgDN5d+POgMAAA==
X-CMS-MailID: 20220615233122epcas2p43646a7b07e34e14187dbecb15a6ac7c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718
References: <20220615121204.16642-1-alim.akhtar@samsung.com>
        <CGME20220615121511epcas5p2d5afbc65ba52aa74cd18834ba771f718@epcas5p2.samsung.com>
        <20220615121204.16642-2-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/3] ufs: host: ufs-exynos: use already existing define
> 
> UFS core already uses RX_MIN_ACTIVATETIME_CAPABILITY macro, let's use the
> same in driver as well instead of having a different macro name for the
> same offset.
> 

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

