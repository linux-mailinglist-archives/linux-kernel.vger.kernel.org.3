Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A874905A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiAQKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:02:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44202 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiAQKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:02:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5388212B9;
        Mon, 17 Jan 2022 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642413767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJmKeizHq6WQTFQ97oG9pwhWoRMnaCiKvK2TrmL7UeU=;
        b=VaK0+JwQuOTEQVdwVDRsUEWZXL5pPa/hwTo3Y8QQyOK8M0MHL5qq2MsH9ZfrbP2s7e9KAH
        lh3mZZ+p/uyLnyY83yd7t0PolW1pWG48kDQ6hJ1lp5jDX2qAx09M98N8R4R1FIaux7qpFV
        kxn09vqltxTwgNy36nBt9E9ZqoPs6ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642413767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJmKeizHq6WQTFQ97oG9pwhWoRMnaCiKvK2TrmL7UeU=;
        b=7psUiaZXvJ0wT2d7Er88CZ09PwNHNGiw3TeLrS3EvjYv/9yqQXk+LhVzmIzBPRFA7OZcet
        3iDTQVAPUTOt0yAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 961F713CF9;
        Mon, 17 Jan 2022 10:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pslpJMc+5WHnRwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 17 Jan 2022 10:02:47 +0000
Date:   Mon, 17 Jan 2022 11:02:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.299-rt230
Message-ID: <20220117100247.yftwn4k4dmvneisg@carbon.lan>
References: <164232885429.16727.14256146043064078052@beryllium.lan>
 <YeU9ahVNB8aLHoBl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeU9ahVNB8aLHoBl@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:56:58AM +0100, Sebastian Andrzej Siewior wrote:
> The uploads still stuck? You want me to ping?

Yep, still not working. I think my last email never reached the right
inbox. It might be due some DKIM problems on my side. I'll try again
with my work email. Thanks for reminding me.
