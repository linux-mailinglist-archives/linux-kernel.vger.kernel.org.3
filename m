Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4249650496E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiDQU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiDQU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:26:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B113F13;
        Sun, 17 Apr 2022 13:23:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t13so15367927pgn.8;
        Sun, 17 Apr 2022 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YA7IRbNQARLk2RzlMdWskeiRCDW2u3CdEM9ANtLGk5k=;
        b=lvZtIgAJffChCy6ZuHuFCOMMhq8w6OUICJ89rZHyIEIAoVUbXmHeVv5vBv8XKr1vG/
         nXAU2JyrLvobdiUbJhc3jHcGJbE9HedYLakda4oH2wsXfLYKvLG4UtKq+ybFKwyc1Jiq
         3ARasePQfbQ9toXuzz0Br03qW0SOMIMsYaE+rakUWaImwdz4z5RGXAAYBq17nxaY9IvN
         OCFFowQwltKLzPuM02dsehET2DdG6yGf4AkE5m070iBKcsm7TB1u6Jo4CvPzdcsoNo+t
         5FEtjnlylIxgBnia+RF+LNxJzzEpXLaJgDwjUgpYrCvQeK217qPIc8ywjnt00vq63jw8
         ngHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YA7IRbNQARLk2RzlMdWskeiRCDW2u3CdEM9ANtLGk5k=;
        b=zw4gnKt6qZ8kxglUYkK/iwxcqP82k1+X+IZMcqLttYWvV8/MdIBNhiM8E/XG+95pYv
         I9cqWalAKn1VgBlT5ipzUhU/aHHEca8lmCoutv7JGvlSph0kp8B60Qpt5T2Oup8YM9Jc
         OPfDsifL+Unc4ZkfoeOxVNM2qr5oPvyyUWAUGyomvluxRS/4uWN1bI6viQ8ejx4u2L6I
         ucQoq30vFLwLZIrAzgkPmiZykkf1AcnscIn6H9qidREprmoKRj9r/dJa9w+oP6Q9PeUG
         GvdX/xakI37xVVqIlOquC0pR02sHVfDMVjYx1A9YRSMb+KADLRZUq+cIO0AGJqUccK3R
         dqlQ==
X-Gm-Message-State: AOAM530crt29B0DZAQlyZhydjCchZwaJotTq2yEuqOpUwaqWRAJqqDI+
        i3vVICbPCJtPDrcSdnMKFL4=
X-Google-Smtp-Source: ABdhPJwPsnqmMQ1/g5mlhsVYb9zC65nqS5AV154iLrK4wK3nXf8Id3kOIoiuCe8f1rWTlMtf6zhM4g==
X-Received: by 2002:a63:ad4d:0:b0:378:4b82:b881 with SMTP id y13-20020a63ad4d000000b003784b82b881mr7532335pgo.282.1650227020986;
        Sun, 17 Apr 2022 13:23:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1752:34a6:ebd3:cc40])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm14804101pjl.39.2022.04.17.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:23:39 -0700 (PDT)
Date:   Sun, 17 Apr 2022 13:23:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shelby Heffron <Shelby.Heffron@garmin.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V3] input: Add Marine Navigation Keycodes
Message-ID: <Ylx3STfwTQEI/3u5@google.com>
References: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <20220414015356.1619310-1-Shelby.Heffron@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414015356.1619310-1-Shelby.Heffron@garmin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:53:56PM -0500, Shelby Heffron wrote:
> Add keycodes that are used by marine navigation devices
> 
> Signed-off-by: Shelby Heffron <Shelby.Heffron@garmin.com>

Applied, thank you.

-- 
Dmitry
