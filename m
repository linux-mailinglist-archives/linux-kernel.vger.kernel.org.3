Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390434F2107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiDECkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDECkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:40:37 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29945158D86
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649123031;
        bh=YJ4G6EfSMlc9a+RsjVXiyuZ8BgneqfFR+sZ3NViWAa8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=VcoJgmeH+G/bqJYalkW6y+7JCqtvl8JcLHWjuJl8UHbB2SXtUlR3FGKNVDgHyQS8u
         0srahIze0xFt3iHb7ZjZrJcj5Ch9YDvTLWFcmkXFQ6i++4YaBHDnOAltOXf9EBb7lF
         BUXKdj7Xy88DRMQa9lSIR/rRPbF12REgv6Zt6gYs=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 2973BC56; Tue, 05 Apr 2022 09:10:23 +0800
X-QQ-mid: xmsmtpt1649121023t61dqi5iw
Message-ID: <tencent_452951FCBB813C31CBE516716C537884D70A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjE4XxrPhxnzYSX90Lp1RulwJjuhj3Ad5DeArzICeNyT6fu7ejU8
         EpiqbiEcoMIZz6o9SV3LKE6o6+gMPUjlc3wP6jH8zA6QAqCcAh4UgL3M83VB+YqEhTZu+3n5S8Kz
         xFomaiy4AoHpOIv7HasvXysadnzVInm4N+9JEsnJgFzb9eTrQVsaxcU16MxQsWNdhVk+Ee1/DrkE
         RLpNvJlBtnH0lLZs3o2XsjmnacJKkxbnn2b/4TnkJxTaR2s6sBZJuP0EgAwUf/FnmVO4nz84hDoD
         GyxG6cUVi9JQ7KS2AGu1huDd/FqV1BkHJcFxYEyCdB/SFOjVvP/rEzv8yNjBZwH46VKMLVW5hODU
         6quiF/NDMaZRVsDBUuSrEdpjQZosnqN8A1HpMVHj7QXCHrmL7i5yhujNDYYzDfScrWhbZM0MXJPC
         7xU+slEAU9HAmdCLSWwExHxk9JJk2zHqsL5MMqu/Kic2Mi9qiLs7OootEky5IdJEkOdzA/YvQxF9
         ZcaQyKdhWYXOafjtUGQdcLXbLL+TNltNfD2JDrV1wKaGj+7Medxt95jLGOnIksPwVKIkCPjAqJ7s
         FMypTzcC6Wqpqa+OWeeEfUj0xfq6ip8ObX45IpjVj5yZyg5N2xaE3xLosvguRW69Bqx0Zz0o1FZH
         CS2DedQQZUNcPBq46WmAaVOzDdJhX5bDkluA24naGPtgWhRJ26k1GhixgiWRsQRe5ONbfLVXskKM
         GVOMQIrjE7q+xQ0ZD2QiGYbXmZRTwQ4T/bfFN7bG+yY+D8jWF92QsoJ7tIn0MembYie0G+CZZpyD
         T+G+0zMBDXkdBUgXoP/exl4mUgvMiEPt0WGej9LbrH2RNlpofWHvu30UMh16GulTv410zkvrgUyJ
         DHXLDc+dJH2TgjPVOSG0QQTh82MqVGnLo6uTx304Vu2dkqnznYGY/eqyyi1lxR2Q==
From:   <xkernel.wang@foxmail.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <Larry.Finger@lwfinger.net>, <florian.c.schilhabel@googlemail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com> <tencent_3096E1464A73FF232014CC40B9001C551408@qq.com> <YksAzXHif7Usdfv9@kroah.com>
In-Reply-To: <YksAzXHif7Usdfv9@kroah.com>
Subject: Re: [PATCH 2/3] staging: rtl8712: add two validation check in r8712_init_drv_sw()
Date:   Tue, 5 Apr 2022 09:10:24 +0800
X-OQ-MSGID: <000e01d84889$ee63d8b0$cb2b8a10$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQO0Uoy989zRJT7S4c8YGkbirmJg/AIqqt/GAmblFDABs2btQg==
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 4, 2022 10:30 PM +0800, gregkh@linuxfoundation.org =
wrote:
> You just leaked memory :(
>
> please please please test these types of "fix up error handling"
> changes, as there are lots and lots of ways to get these wrong.
>

It seems that you missed the third email in this series.

In fact, I did not ignore the memory leak problem. But considering that =
there are other paths which can also lead to memory leak, I separated =
another patch to deal with them specifically.

In the next version, I will adjust the sequence of the patches and add =
some descriptions to explicitly show the relations.

--
Regards,
Xiaoke Wang

