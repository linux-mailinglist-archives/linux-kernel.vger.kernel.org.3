Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8057DF53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiGVJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiGVJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:35 -0400
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CBC31903
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:34:19 -0700 (PDT)
Received: from [172.16.17.104] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Ep2jobs55NP7IEp30oEky9; Fri, 22 Jul 2022 11:34:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1658482456; bh=hXiR3PFxdSbu6l4gHBdPwGcOeFZmSpMU2B5/+k3KNSI=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=HIrZNhgm2/S0QBlJ8Xsz39imdWJcybalYzrOSBVVgrAbu1t27qntyaSZZx3Tk2ORC
         UuaOzhO6ZNiHmgPtw8Ai2s17pSGN+nvvnJ9j8saiq4/WeSb+2OfN7xRWJ04+Jl7m43
         KB+zdPagOA7OtmmBIoPWFUBNatrtpDE+Vz5iYdpybtECu0JP540sj4QNnsPtGSWa9v
         ygZyXhbipHKW3deleO3PdzPq1DysXeh8mRG3ShwhGSHifsA+gNfpj7PNIuPWEF/9VB
         r5SYcXWHRDcIKVcy4zB9k1LxODu6+sHHOvdZQsybS2ecovVj7qbOdviCPBoFgcmwFb
         /SHPanlYUmEhA==
Message-ID: <7380f93a-f066-907e-e986-23b398ef181c@brickedbrain.com>
Date:   Fri, 22 Jul 2022 11:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] ads7846: don't report pressure for ads7845
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
 <20220721083458.6412-2-luca.ellero@brickedbrain.com>
 <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGwFzw5w/CHhEnH0pya41TmYd/okrKiS7vgGrWp75RZgus8IvIAGEn+jsQu99OgjRrnKA2zimppoBRKj8AjYiTIykzXXpRT/ig/j0Fq5+uN4juXM6j7t
 odED8k8b4SBFvMpG/guqbWydybrmHY0Tio6TzWV6q9mwVCvmw/cKErLb8xtNsddAU+9JD4nczP3rc51qJMLI/b8wc+6klwNOvr7xofLj6Y410UZ2PmjGt5PF
 CtAavSLKgvY5AMZoWagOZcPgBAYJ/VOwid4x2PT75bO+XtvrdBpSnQXIU/TdVmiBugnqVjVG+mNoSA9Q58OQTMiX14lGiawlc8/k108zlNHQK1TPJtqe6Cu7
 Vo00j8anitApBQZfc4L+bfZnz7FxStbTRRODiBUAWPALYch/Zy+eq1A+3qb/EFR+Gi0XLDKFiWQD6hp7LLjahM5x8cPmiNBWbnGe3dPsZl7soVAV2v7GevaQ
 2SE9kIDWE8XKW01TD7/1/x76Q185qu56//1NwhzT2qN0f16PQbLrF7uOm4cgGwHS4tn4Xjgy7plMcYK+CN16Lr6Lk535oAuU7ukDMDfQv+5ofj21EYuFPWFP
 UBw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/2022 22:48, Uwe Kleine-König ha scritto:
> On Thu, Jul 21, 2022 at 10:34:56AM +0200, Luca Ellero wrote:
>> From: Luca Ellero <l.ellero@asem.it>
>>
>> ADS7845 doesn't support pressure.
>> This patch avoids the following error reported by libinput-list-devices:
>> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
>>
>> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> 
> I don't know how picky Dmitry is, but some maintainers would ask you to
> either add a Signed-off-by with the email address you sent this patch
> from, or make sure to send it from the asem.it address.
> 
> Best regards
> Uwe
> 
Hi Uwe,
thank you for your comment.
I have some problems with our SMTP mail server, but if needed I can
resend the patches with the proper email address.
Regards
Luca

-- 
Luca Ellero

E-mail: luca.ellero@brickedbrain.com
Internet: www.brickedbrain.com

