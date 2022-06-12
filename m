Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F895479A7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiFLJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFLJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:43:01 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0612D12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:42:58 -0700 (PDT)
Date:   Sun, 12 Jun 2022 04:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1655026977;
        bh=IQ9prYlA/J6R6f9MDzLadU8e2oAyTtHh3QWFvqikGiM=;
        h=Date:From:To:Message-ID:MIME-Version:Content-Type:
         Content-Disposition:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=CMzxHsX+B6snFcxoNO0n6joRaeBTj2cXH2FcFUdR3KoMFyAOwZL9lD7kz/RJ5V05C
         uXoBnrR18JUGTikNRw+vCLAhvUYPUcEg+sNvqlnzQFHuTmNuCW6jxPbgGPlyHBDFjX
         q910ViQzV7B2df3jhBeRp1LaRE+1XJ6vuHLU5Om+HMz2S29nTX9oaZWTWdD7hEwQ5m
         DQdrbTShRnUp6/x6hyJpRLXAhveaCXsshH1j9LFjNCyykZWZhKooooEC7KvyUaOTGq
         gza5aljj1yDRWhB0jqR/oLnpgaJejpuRMi70maKCYDdUfUl8bRzPO92rJY3mwJ7Qlp
         fuFWtryGfBFYg==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, a.zummo@towertech.it
Message-ID: <20220612094253.4rgbp3mcc44nffl6@proprietary-killer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alexandre.belloni@bootlin.com
Bcc:
Subject: RTC: utility function: days to year/month/days?
Reply-To:

Hello.

I'm currently working on a rtc driver for my soc (HiSilicon Hi3521a, and
at least one other, potentially more), and it stores time in the
following registers:
RTC_10MS_COUNT: 7 bits, 10ms increments
RTC_S_COUNT, 6 bits, 1s increments
RTC_M_COUNT, 6 bits, 1m increments
RTC_H_COUNT, 5 bits, 1h increments
RTC_D_COUNT_L, 8 bits, 1d increments, low bits
RTC_D_COUNT_H, 8 bits, 1d increments, high bits

No months or years. Is there any utility function one could use to
convert 0-65535 days into year/month/days already in the kernel, or is
that something I'll have to roll myself?

Mail receipients taken from ./scripts/get_maintainers.pl -f
drivers/rtc/rtc-core.h, so if I'm pinging someone I shouldn't, my
apologies.

Regards,

Marty Plummer

