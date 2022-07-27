Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C135825E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiG0LwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiG0LwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:52:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60115FD9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:51:58 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220727115152epoutp0186f4fe25a3e4753ca6abea1aea1dfcba~FrWreF_Xm1475714757epoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:51:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220727115152epoutp0186f4fe25a3e4753ca6abea1aea1dfcba~FrWreF_Xm1475714757epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658922712;
        bh=9KNSmCuxUDDagsNVI0cNFqmCLS2hBLt5TUCX8g9a7po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T95vmL9XSI7qG2I2Y+xQ9G6CmcT2Pnbt9AZ3KZp3pKEsbYMmPj/y+da0U0JhLPsjM
         v8I2JzcGAX3fOtzC25OVYcPL0H24+bBR4I3rubzgPRviURsLM7phgmzAKLUF4QgSGc
         4SSfmD9ZSjRtOf4IFLLWHFrS5pJngKwaqTjjxq68=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220727115150epcas1p16f527446c0e8d5278376dc05bed75553~FrWqMSl_12158221582epcas1p1k;
        Wed, 27 Jul 2022 11:51:50 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.231]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LtBvn6QKJz4x9Pp; Wed, 27 Jul
        2022 11:51:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.12.10203.5D621E26; Wed, 27 Jul 2022 20:51:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220727115149epcas1p124467d885485ed97ef7fa4d89b77f637~FrWolvnEc2158221582epcas1p1j;
        Wed, 27 Jul 2022 11:51:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727115149epsmtrp2513b289e1acf87663d061cf00dad91ba~FrWokqPBJ0427104271epsmtrp2w;
        Wed, 27 Jul 2022 11:51:49 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-ba-62e126d5b03a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.00.08905.5D621E26; Wed, 27 Jul 2022 20:51:49 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220727115148epsmtip1db663b829dc0dfd3e0124212cef613f9~FrWobGLO10501205012epsmtip1A;
        Wed, 27 Jul 2022 11:51:48 +0000 (GMT)
Date:   Wed, 27 Jul 2022 20:51:48 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
Message-Id: <20220727205148.8867516678d51bd2439d27da@samsung.com>
In-Reply-To: <70255b63-294c-bda6-e7ad-7009f735b336@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTX/eq2sMkg9tn9S3+TjrGbtG8eD2b
        xfvu3cwWe19vZbe4vGsOm8XtxhVsFs+nXWdxYPf4/WsSo8eda3vYPPbPXcPu0bdlFaPH501y
        AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
        KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEK
        E7Iz9p3bx1awmKPib9Ne1gbGo2xdjJwcEgImEt2LGli7GLk4hAR2MEpsfDmFDcL5xCjReuMC
        lPONUWLrxx9wLTc2TQGzhQT2Mkr8/64FUdTBJDGlax07SIJFQFWi9846JhCbDcieOWMNWFxE
        wEJi8YaFYPuYBRoZJf41fAArEhawkvh8fx1zFyMHB6+Ao8SCb0kgYU4BO4mlD7ZCLbaQuNuz
        ghWiRFDi7w5hkDCzgLzE9rdzmEFGSgj8ZJf4fusgI0S9i8Tx6b3sELawxKvjW6BsKYnP7/ZC
        zcyWmNKxiAXCLpA493wr2AkSAsYSF1ekgJjMApoS63fpQ1QoSuz8PZcRYi2fxLuvPawQ1bwS
        HW1CECVKEkv+HIZaJCExdcY3JgjbQ2LG2quMkJA6zChxcvI25gmMCrMQnpmF5JlZCIsXMDKv
        YhRLLSjOTU8tNiwwgUdvcn7uJkZwmtSy2ME49+0HvUOMTByMhxglOJiVRHgTou8nCfGmJFZW
        pRblxxeV5qQWH2I0BcbMRGYp0eR8YKLOK4k3NLE0MDEzMjaxMDQzVBLn7Z16OlFIID2xJDU7
        NbUgtQimj4mDU6qBybzncuB/n/TLPNMmv7oyJcFr1d3zvLfvS11dFJWtaSEUHi/3c5EVy+UH
        Dy4/72s86j5nnuePdSrSv8QqVdd4//wh36RtuTpOJOAv1w/7ZZqzfy+xvT236gXv5bdrld+s
        YuOzXPBI4rz2uil7I+7zeF+9zLvpz8SZ/+4YcrAdcf/4e8K65VsFtPY5Hf2cwKv/66zrK5+m
        36v55jxT32q1fQ3PKxat5Vt99P/HtrOUFhrI+J9V77T7MG1a94W6v8zL/vYwK7i+/aahK7Sl
        dfGv9L817kdZvxWrCSppzn6191pNy7S6Yy/v7/k+ad/3lvl5SbcufA0pjNZy/n2O78qHGM7e
        TZJCagv9RF4VuN9UXLNCiaU4I9FQi7moOBEAJz8vVxwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO5VtYdJBt/2sFn8nXSM3aJ58Xo2
        i/fdu5kt9r7eym5xedccNovbjSvYLJ5Pu87iwO7x+9ckRo871/aweeyfu4bdo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDL2ndvHVrCYo+Jv017WBsajbF2MnBwSAiYSNzZNAbK5OIQEdjNK
        TJ+6ih0iISGx6d5y5i5GDiBbWOLw4WKImjYmiaXNN8FqWARUJXrvrGMCsdmA7Jkz1oDFRQQs
        JBZvWMgK0sAs0MgoceTDMmaQhLCAlcTn++vAhvIKOEos+JYEEuYUsJNY+mAr1BGHGSVOTt7G
        DHGEhcTdnhWsEPWCEn93CIOEmQW0JB7+usUCYctLbH87h3kCo+AshKpZSKpmIalawMi8ilEy
        taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOAa0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHehOj7
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwua8u1XvU
        86T32rutj5puRRVx6px5ZMGZnco385O6iMjZTCfnj/FGZqx7sm/snDzn2T1ddUfH0Fc51luZ
        feVsJipM8FwWtzvkWMWBpiMfj8/NW6P+e5Ubh5V1Lmf6g5U2KiI/nvsd4m727eNoaV7hl/0p
        89T0ssbY5dznGGdt2s3NLqLinz3bQ94uKlH9XvKRpzFLYrZGpi7v29K07GVDRZHQunbRQ81r
        js3d3ZmyWcQi4Zr+SxW7U88OLt2wtnNb3/6ZWlFnNezuP5dm446qznizsukLx52Nj+c2Gzjz
        Nys1330+LX5rbkN5qblYfsbDnDUx22+92fxH3mJZ1OygOD35nYJH3DbGHOVOvZCoxFKckWio
        xVxUnAgA9dJnjfACAAA=
X-CMS-MailID: 20220727115149epcas1p124467d885485ed97ef7fa4d89b77f637
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065308epcas1p2f6de3d74792854bb312cca4b310badac
References: <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcas1p2.samsung.com>
        <20220725065308.2457024-1-jiho.chu@samsung.com>
        <70255b63-294c-bda6-e7ad-7009f735b336@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 08:57:08 +0200 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/07/2022 08:52, Jiho Chu wrote:
> > Hello,
> > 
> > My name is Jiho Chu, and working for device driver and system daemon for
> > several years at Samsung Electronics. 
> > 
> > Trinity Neural Processing Unit (NPU) series are hardware accelerators
> > for neural network processing in embedded systems, which are integrated
> > into application processors or SoCs. Trinity NPU is compatible with AMBA
> > bus architecture and first launched in 2018 with its first version for
> > vision processing, Trinity Version1 (TRIV1). Its second version, TRIV2,
> > is released in Dec, 2021. Another Trinity NPU for audio processing is
> > referred as TRIA.
> > 
> 
> Why there are no bindings? How is it supposed to be used on ARM64 platforms?
> 
> 
> Best regards,
> Krzysztof
> 

Hi, Krzysztof
Thanks for your review.
A dt-bindings document under 'bindings/arm/' is being ready, and it could be included in v2.

Sincerely,
Jiho Chu

