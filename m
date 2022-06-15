Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082354C07A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiFOEDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiFOEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:03:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705E2A274
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:03:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03C0621BB1;
        Wed, 15 Jun 2022 04:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655265813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eqDuYB80I3d0HyyEyahmVrfsZakMPNp24PF0vO9N8A=;
        b=CI8e7A5zauep2QKJgpBZD6JuXlBXvGoQ+aDz04oU16m8rYWa3fAt+GdDn1rRX/lqZLdnSM
        6t6wpV59usEyofWKqQacxOi8cTV6j5Ye3d1/ALcJ2fwLgfQtve1A3/JIa0jOBRXQwFRuTX
        pMaOX77bAHWoKF77BWkofMP0NGUDwMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655265813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eqDuYB80I3d0HyyEyahmVrfsZakMPNp24PF0vO9N8A=;
        b=KZqkR1CqWdVbGZX2onIRNZldZsg1Opb5C2GL5E4lXZwZX1AEEuE25DpoWE2rY27gYml92i
        mm3FZNhb9dU2BaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A062B139EC;
        Wed, 15 Jun 2022 04:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qWElJBRaqWK+RQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 15 Jun 2022 04:03:32 +0000
Date:   Wed, 15 Jun 2022 06:03:31 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-ID: <YqlaE/LYHwB0gpaW@localhost.localdomain>
References: <20220610101258.75738-1-david@redhat.com>
 <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
 <20220614103842.af0c9a5434e3099cf9060cf5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614103842.af0c9a5434e3099cf9060cf5@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:38:42AM -0700, Andrew Morton wrote:
> On Tue, 14 Jun 2022 08:58:55 +0200 David Hildenbrand <david@redhat.com> wrote:
> um, fine, no opinion really.  I think the main thing is to make
> get_maintainer.pl spit out all the suitable email addresses.

As already pointed out, David and I have already kind of acted as maintainers of
this aready already for quite some time, reviewing and contributing the most, so
it might make sense to just spell that out, so, without willing to step on
anyone's toes, what about this:

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..f5a746624a9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12857,6 +12857,18 @@ F:     include/linux/vmalloc.h
 F:     mm/
 F:     tools/testing/selftests/vm/
 
+MEMORY HOT(UN)PLUG
+M:     David Hildenbrand <david@redhat.com>
+M:     Oscar Salvador <osalvador@suse.de>
+L:     linux-mm@kvack.org
+S:     Maintained
+F:     Documentation/admin-guide/mm/memory-hotplug.rst
+F:     Documentation/core-api/memory-hotplug.rst
+F:     drivers/base/memory.c
+F:     include/linux/memory_hotplug.h
+F:     mm/memory_hotplug.c
+F:     tools/testing/selftests/memory-hotplug/

Thanks

-- 
Oscar Salvador
SUSE Labs
