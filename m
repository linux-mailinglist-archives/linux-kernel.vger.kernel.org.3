Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4174FB9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiDKKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiDKKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:31:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C2E46
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4EAE1F7AC;
        Mon, 11 Apr 2022 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649672960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTsLWEOgudRX67SU7WacVxA1xJ/H228d5+aH8WdCNIY=;
        b=i66heOiWO7Bhw2Mhd6HH3pfB5Lab1AwE7Hy1WYFxLjllpw4qq7TmE7/F37dRecVCviU6RX
        v3qS4JXwreWhleWP1gyxG4CxrrXTr+9Or4lr/TwjM+hGtpseurHdIKhbFrlAAWHN0+6y6S
        qsJt1lOuq1oqAK1dWU11M7E5ppYQ6Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649672960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTsLWEOgudRX67SU7WacVxA1xJ/H228d5+aH8WdCNIY=;
        b=pqDaOM2ZqRrwytVAMLZ2VhAnFcpuBxpckrnD5LzdfdPHLc9038NlGvBYEgrG52qd7smA5j
        kTj1AbxsBqmgGdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3863013AB5;
        Mon, 11 Apr 2022 10:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WDcnCgADVGJyYAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 11 Apr 2022 10:29:20 +0000
Date:   Mon, 11 Apr 2022 12:29:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] ns: Rename MAX_PID_NS_LEVEL to MAX_NS_LEVEL, move
Message-ID: <YlQC/QNz+JJWWPwN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220330094703.26075-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330094703.26075-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

...
> +++ b/include/linux/ns_common.h
> @@ -4,6 +4,9 @@

>  #include <linux/refcount.h>

> +/* MAX_NS_LEVEL is needed for limiting size of 'struct pid' */
Hm, I forgot to amend the patch. This was supposed to be:
/* pid and user namespace */

I can send v3 if is patch considered useful.

> +#define MAX_NS_LEVEL 32
...

Kind regards,
Petr
