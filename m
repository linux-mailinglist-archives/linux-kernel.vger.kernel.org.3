Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC600596281
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiHPSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiHPSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:33:15 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8ADFB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:33:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 32BA720152;
        Tue, 16 Aug 2022 20:33:10 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7tRi_zDqDyJn; Tue, 16 Aug 2022 20:33:10 +0200 (CEST)
Received: from begin.home (lfbn-orl-1-1261-6.w86-244.abo.wanadoo.fr [86.244.81.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id EF4BF20148;
        Tue, 16 Aug 2022 20:33:09 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oO1NG-00GqGt-0x;
        Tue, 16 Aug 2022 20:33:10 +0200
Date:   Tue, 16 Aug 2022 20:33:10 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCHv4] speakup: Generate speakupmap.h automatically
Message-ID: <20220816183310.uvmcojucjdhcb4vk@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Nikita Travkin <nikita@trvn.ru>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
References: <20220612172244.il3siyq7ueqnvah5@begin>
 <20220816072843.1699317-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220816072843.1699317-1-nikita@trvn.ru>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Nikita Travkin, le mar. 16 août 2022 12:28:43 +0500, a ecrit:
> After that I also had some weird issues of the build system trying to
> write speakupmap.h into the source dir and not the output dir (the
> source is read only due to the tooling I use) but this seems to have
> been resolved by cleanly rebuilding the speakup dir.

Mmm, how did you get/update your source dir? The latest version of the
patchset does generate it in the build tree.

Samuel
