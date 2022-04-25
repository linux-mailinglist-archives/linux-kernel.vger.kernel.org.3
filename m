Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D850D9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiDYHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiDYHN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:13:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F77220C5;
        Mon, 25 Apr 2022 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=B9WB+hwhosJvYbo65GHTbgrVCXpNO9OFYMi8Pd4ssjM=; b=oGM378hpwyyWgNK+VOIA1H0x7u
        WtffthAd0NQPAVqMFccjAax977qkbil5cGtMEF50TXta1rBKXer3eWMh0HcGudRb8WPBY8Rj4POso
        rPt4H6mv+Q84MHv3IW6y74Rn8eH2LVIfIoarXYimaKR8KvKfFiNOJmI4TZ5/aPwU2CXksdr8uCmQC
        j3X19KKGSDUMPVNHXowbu2a6WJx+OlNWWlz8wQDfyszGRhXvz85GIFVF5Giz5ZldYccQ2pV0AXk5H
        XExvNE3b2YOh3F1vzIP/3FLUAmj8NSavUmbnERzRhFPGVVDEn9eNVjCJAZpQNLCJmNanv02ZYb9BH
        nu+Gdy1w==;
Received: from ip171.dynamic.igalia.com ([192.168.10.171])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nisrR-000CQI-LG; Mon, 25 Apr 2022 09:10:17 +0200
Message-ID: <890f6416ab37e40c929d95a8b4dcc8feb3dfb4d1.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Fix null pointer dereference of pointer perfmon
From:   "Juan A." =?ISO-8859-1?Q?Su=E1rez?= <jasuarez@igalia.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 09:10:17 +0200
In-Reply-To: <20220424183512.1365683-1-colin.i.king@gmail.com>
References: <20220424183512.1365683-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-24 at 19:35 +0100, Colin Ian King wrote:
> In the unlikely event that pointer perfmon is null the WARN_ON return
> path
> occurs after the pointer has already been deferenced. Fix this by
> only
> dereferencing perfmon after it has been null checked.
> 

Good catch!

Reviewed-by: Juan A. Suarez <jasuarez@igalia.com>


	J.A.

