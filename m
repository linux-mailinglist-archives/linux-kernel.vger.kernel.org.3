Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1F4F7C19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiDGJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243982AbiDGJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:48:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75030103DAC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:46:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB02621122;
        Thu,  7 Apr 2022 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649324811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgM3qKvpr5jvC+0GuUS9jBSYpQriyZSGnkTlKi+9d5A=;
        b=n+GJVpotSnkfzJKFBATwz1SVbXx+v1orM09qbFzoR5FTgc7+r8UivASl39Mwbu5kLllfzu
        DEA6/WcdTHJ9VS6Zf7ztAm0W7PHJKZKWcG4iySXIEfvph4dGIBY8XAmods2URk+qkAeUGz
        XGTczTCJhBy+hsZNm/OBeedOdbYg39g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649324811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgM3qKvpr5jvC+0GuUS9jBSYpQriyZSGnkTlKi+9d5A=;
        b=L7/H3pg3FuMOAln5tiNZ+WcfJSO7ws5jre6dCk8A+GYADIHwJqQT0ySdj2sU4EGs4cooRJ
        BvpGxNzJlZ7++mBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAFC013A66;
        Thu,  7 Apr 2022 09:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id itvsMAuzTmINNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Apr 2022 09:46:51 +0000
Message-ID: <b2bd760f-b4aa-d357-e3a9-4236228225f9@suse.cz>
Date:   Thu, 7 Apr 2022 11:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slab.c: fix comments
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220407080958.3667-1-caoyixuan2019@email.szu.edu.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220407080958.3667-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 10:09, Yixuan Cao wrote:
> While reading the source code,
> I noticed some language errors in the comments, so I fixed them.
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

Added to slab tree, thanks.
