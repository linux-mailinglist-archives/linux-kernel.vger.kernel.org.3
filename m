Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE64567261
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGEPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGEPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:21:47 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965D186C0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:21:46 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id CED62592E56A3; Tue,  5 Jul 2022 17:21:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id CE5E360BD5222;
        Tue,  5 Jul 2022 17:21:44 +0200 (CEST)
Date:   Tue, 5 Jul 2022 17:21:44 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Takashi Iwai <tiwai@suse.de>
cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: snd_cs46xx regression, producing Oops
In-Reply-To: <875ykbvklj.wl-tiwai@suse.de>
Message-ID: <pprs942s-n3s9-9so5-191s-o6qqq9s31poo@vanv.qr>
References: <p2p1s96o-746-74p4-s95-61qo1p7782pn@vanv.qr> <875ykbvklj.wl-tiwai@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2022-07-05 13:56, Takashi Iwai wrote:
>> 
>> Commit v5.14-rc1-39-g5bff69b3645d introduced a breakage into
>> snd_cs46xx.
>
>Could you try the patch below?
>Subject: [PATCH] ALSA: cs46xx: Fix missing snd_card_free() call at probe error

I confirm your patch cures the oops.

>Fixes: 5bff69b3645d ("ALSA: cs46xx: Allocate resources with device-managed APIs")
