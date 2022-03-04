Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FF4CD812
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiCDPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiCDPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:39:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6E47065;
        Fri,  4 Mar 2022 07:38:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C76D921124;
        Fri,  4 Mar 2022 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646408327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQnxl0eqs4bZW5zPw9qVTxkPmfJfmM4RO01wXd5QUQQ=;
        b=EF2IE8a9r/nl6g8fM+ZC95CZCxjVmOxMilo6b1d/slFk5tHxyhxh5aM7OgeRJy4o8I82la
        punlcJSNBD4zqXIj5f/6A47Rx0cNzuZEDztXtQmzJguqISeENc8yZVXa9IxRRuUa5G4gV8
        QhNX08P/btaAwJfi7FvptAYUa+GpCfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646408327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQnxl0eqs4bZW5zPw9qVTxkPmfJfmM4RO01wXd5QUQQ=;
        b=/IUqc6BhQy0N2yctMiiIV7VHLvt7EftsqxKvWCPSBWMDQdv1vETb6L5/e2BpzV/bj5h9SA
        QtdtgWvhudTSh3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8C3B13B64;
        Fri,  4 Mar 2022 15:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JOwDLYcyImLCMwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 04 Mar 2022 15:38:47 +0000
Date:   Fri, 4 Mar 2022 16:38:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] block: remove commented out code from diskstats_show
Message-ID: <20220304153847.bannj7cgo4z7vonl@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-2-dwagner@suse.de>
 <83b281e5-16c2-d659-172d-3a2c911c7ff0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b281e5-16c2-d659-172d-3a2c911c7ff0@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:02:49PM +0100, Hannes Reinecke wrote:
> On 1/20/22 11:52 AM, Daniel Wagner wrote:
> > The diskstats format is ABI, so we just can't add a new header. The
> > code snippet has been commented out since at least v2.6.12-rc2.
> > Remove it.
> > > Reviewed-by: Hannes Reinecke <hare@suse.de>

Any change to queue this patch up?
