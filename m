Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3975204AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiEISpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiEISpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:45:38 -0400
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978E16D5CD;
        Mon,  9 May 2022 11:41:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1344616|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00187464-0.000480582-0.997645;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Ngqf20o_1652121690;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Ngqf20o_1652121690)
          by smtp.aliyun-inc.com(33.13.195.200);
          Tue, 10 May 2022 02:41:31 +0800
Subject: Re: Question about SC16IS752 device tree.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     jringle@gridpoint.com, shc_work@mail.ru,
        Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
Date:   Tue, 10 May 2022 02:41:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/5/10 上午2:13, Paul Cercueil wrote:
> I can't say for sure that it's your problem, but your bluetooth nodes 
> are missing "reg" properties. 


Unfortunately it doesn't seem to be the problem here, I added "reg" and
the problem persists, and I've looked at other device trees that contain
"brcm,bcm43438-bt", none of them use "reg", and "reg" is not mentioned in
neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt" nor
"Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".


Best regards!

