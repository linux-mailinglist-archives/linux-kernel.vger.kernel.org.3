Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B97523238
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiEKLzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiEKLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:55:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF86131F22;
        Wed, 11 May 2022 04:54:58 -0700 (PDT)
Date:   Wed, 11 May 2022 13:54:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652270097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ik0+Jc80krWiudtLaGNDRbmUn/iIBLzgEWndCzx/YpI=;
        b=yM8YAfM761iJSlXTBG+cYM7dxLdwq9Yz5gROVT50m3CT1FZlNFH4KV6ute57MDfKE9MLLR
        PyFwQIqajTbevXyQJqVRTQZP64y6sjh1Z/coN5IDA0aA0K8hJtDT3BQGcWLudJXG9ZfK6I
        GCGLPeay7C2aC05OyjmfqbjSfYQk16sCV/V2YGxCxvYWsPSXSF2vr76QDPTLCLp4Kvklvp
        9UKvrtocrM+808KryTTTCKlUI/oRYtbK5m2PmXTWHQBw1JJvD9lZHwROHjlzsUKbBGft7w
        LGEtlV2urH/JRn43gB+1X303D88DmmzlyL6y5IXeUWsey6T26Els3fau438RkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652270097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ik0+Jc80krWiudtLaGNDRbmUn/iIBLzgEWndCzx/YpI=;
        b=Fn510XHqq7PmT/MhN4djHSJEujyLM+OrL0suSPcsJbAAQCRd11c6eeD6aXqZSQ+drM0wTg
        6k1GbnuRZ8Nle8DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT][PATCH 2/2] tick: Fix timer storm since introduction of
 timersd
Message-ID: <YnukEFBsOJqBnq9j@linutronix.de>
References: <20220405010752.1347437-1-frederic@kernel.org>
 <20220405010752.1347437-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405010752.1347437-2-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-05 03:07:52 [+0200], Frederic Weisbecker wrote:
> If timers are pending while the tick is reprogrammed on nohz_mode, the
> next expiry is not armed to fire now, it is delayed one jiffy forward
> instead so as not to raise an inextinguishable timer storm with such
> scenario:

The series of two has been applied.

Sebastian
