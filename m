Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3A494E12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiATMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:41:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47136 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiATMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:41:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8092218E5;
        Thu, 20 Jan 2022 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642682469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3c+REvOXduf40ohZFQKP1DZ0gy+upNEXgXXn54qp3k4=;
        b=AeaQ2LPgmeZrSs44oYV4ZXI2ZTlQVLiCw+NY1hvDhubOFReQNGVixykR2gkXK3k5E+501q
        O/vQ2uEZAaem3pxkNHBHCQ0J7CDedA3cR/nc4vc1nvNEPIOvgxTWUf/0Cm+ykuW4jE/yA6
        g5RiLS61mvEvI0nMys+e+jrydsBSX6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642682469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3c+REvOXduf40ohZFQKP1DZ0gy+upNEXgXXn54qp3k4=;
        b=d5LU8Ruad9lWCTeXy2igrAoSGWcMMJ/8V2+9YdSRj/EkZLxhbSFpV767hIJHi+yP5YYSBI
        7Y+DYMs1guUxbgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 976CD13E9E;
        Thu, 20 Jan 2022 12:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sQvPJGVY6WEaZQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 12:41:09 +0000
Date:   Thu, 20 Jan 2022 13:41:08 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120124108.vux7fa6noipzr32r@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <bcd9ee08-d751-84f4-7334-b107ee3ca294@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd9ee08-d751-84f4-7334-b107ee3ca294@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:18:24PM +0100, Hannes Reinecke wrote:
> On 1/20/22 11:52 AM, Daniel Wagner wrote:
> While this looks good, it seems to have been cut against an earlier
> branch; the code in question looks different in my copy.

This was cut against linux-block/for-next. Let me know which tree/branch
I should use.
