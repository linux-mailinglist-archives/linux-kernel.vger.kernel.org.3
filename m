Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD059D299
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiHWHtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiHWHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:49:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E294DF0B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:49:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5A005CE3B;
        Tue, 23 Aug 2022 07:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661240939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGHlWdvnBeHk92ACym3bq91DmzpEgoS6zL8C8Nn3/TM=;
        b=uS+R/agkh3EO6JM/iLIH7mOR7PF/U0sRQFEgPVOfkdDfKZmuveB2rrR9DE9raLvQ9TG/f3
        4S898IUf0KLrIvjmeqdNyjS2aGOwuxuklcxWrNTb+CGfOp6GmT6xzeczVwyR4gYRh5uSAz
        Ttsw5gpU65lflm/4kJm3HV5KKlXnCFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661240939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGHlWdvnBeHk92ACym3bq91DmzpEgoS6zL8C8Nn3/TM=;
        b=h/B6WVkSxoEda8qZ22fs5HRe9TWdM+beMLDlaGaeuE8RG42GyFl4E06pjtkK2s5LeU6dPs
        AdVR4qN/1eH+ZeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78AB913AB7;
        Tue, 23 Aug 2022 07:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4dnPG2uGBGPLRAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 23 Aug 2022 07:48:59 +0000
Date:   Tue, 23 Aug 2022 09:48:57 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] dmi update for v5.19
Message-ID: <20220823094857.27f3d924@endymion.delvare>
In-Reply-To: <20220822141930.5f43b5e7@endymion.delvare>
References: <20220822141930.5f43b5e7@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 14:19:30 +0200, Jean Delvare wrote:
> Please pull 1 dmi subsystem update for Linux v5.19 from:

s/v5\.19/v6.0/, of course.

-- 
Jean Delvare
SUSE L3 Support
