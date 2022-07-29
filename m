Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA24584D53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiG2IYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiG2IYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:24:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA72282;
        Fri, 29 Jul 2022 01:24:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DDC3343F6;
        Fri, 29 Jul 2022 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659083091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVUw/ScUkBbwG3qhNKtC/NB/sbj9kZuurJ959BkLRak=;
        b=lee2ID6yMMH26vjwNI4b9rAzitPEHp94J3A8/cIjm9DcHp6xiW4RrO6HbQtt7wPbcpQ7q6
        STW2MtF/mB67aTBbj70Sp5digv6tl8inqW6JlBFah70BhE6cfRqCHNEDXdPGB4D195fkHq
        bGdnCOX4U80V2818iDStDYQJe0cwjZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659083091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVUw/ScUkBbwG3qhNKtC/NB/sbj9kZuurJ959BkLRak=;
        b=GsW95GJzafObw/GEFoVkzE2wHD+dL6UDeOFdcRklwmGmceSmamc+iyPoNJNUBS8Tt7/gEP
        xjwdUb3jtoE/AdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A29913A8E;
        Fri, 29 Jul 2022 08:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 266DBFOZ42JfRwAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 29 Jul 2022 08:24:51 +0000
Date:   Fri, 29 Jul 2022 10:24:49 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, lpieralisi@kernel.org,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] ACPI/IORT: Fix build error
 implicit-function-declaration
Message-ID: <YuOYikGcgQe8MMXq@suse.de>
References: <20220726033520.47865-1-renzhijie2@huawei.com>
 <bc4ec60d-3abf-efd9-6536-cec24c6b19ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4ec60d-3abf-efd9-6536-cec24c6b19ef@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:54:59PM +0800, Hanjun Guo wrote:
> Lorenzo, will this patch go via ARM64 tree?

No, this needs to go via IOMMU tree, as the problem is introduced there.

Patch is now applied, thanks.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

