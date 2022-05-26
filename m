Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5A535122
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbiEZPCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEZPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB155481
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF0761C04
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E18C385A9;
        Thu, 26 May 2022 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653577328;
        bh=HVv8uR+w4LK0EMeNaG8v21kPkQwm6nP7gEVJ1y+cQcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw9P4qqQedhPoj6cnqZVxR/93d/u3W9zzlMAI9uG3HuPeuW78jEiX4vc8J20qGI6l
         kWzjOjoKjJAtcy4gVJCbGPPqi4anOtMelojUa/0DaBbP3kK2yWloFUq8jpp0G8oUSu
         AN9XCZsKUFxtB68rvIQTyGp/WUErQsZuk0iZau3GMu4nXX+JbYCPiLPR2rlYl1ZlkE
         1KJTPu1rA4vqfT/rTXiMcyO5mGl4qP/Gacg0GkYC9sWafJeDbd/d1OWkfOMRAk024Y
         +Lw+t7neKAsf0l20HaEndsFe3w1cdw0y+l6Dv6WrPaOXR7KVU4etQQEnRtKD+yi+v4
         J2pXnMlm2GPiA==
Date:   Thu, 26 May 2022 08:02:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 7/7] context_tracking: Always inline empty stubs
Message-ID: <20220526150206.rqdiyouxmkdgm2jq@treble>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.134113388@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526105958.134113388@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:52:59PM +0200, Peter Zijlstra wrote:
> Because GCC is seriously challenged..

Or are these CONFIG_DEBUG_SECTION_MISMATCH?

-- 
Josh
