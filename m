Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B04FCD84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbiDLEUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiDLEUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:20:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364031E3F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:18:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z15so9069160qtj.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d3gadAUNlKv8bSmk8ozUNQ57JoV0EMyK41V7hk2NsaY=;
        b=pQ8XobVHV9m4ZwlpgncYHftEUXqi3sygBZ3wETiMY+vZyy+zyFdCiEwkKc8LRc/Cve
         2O57NQ/ItTJ/Bu6oQaA0BY50T7mTO0ZszeGUz4vB0PFjDJkAVhrYO3e3l9k39K/1hRJb
         OxSmSw9PxvtcZqpEtCqmk4m3/48moDM6PibvpksaP06U0HisjLTX+LqYnkQk2dlo08xo
         JqZGSXZWBpvs9/ZNVuoGN08c2HczpOpwZWlS9heRNu6cGVb0z+lsKJuWTb7Yy1A+wSTz
         FS6OTUbyfwdvrJebIaBfPlip6e0NmKG6dp6WRz8PsY/Qre0y1A+BLfuRR95UrrPeAyaI
         q+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d3gadAUNlKv8bSmk8ozUNQ57JoV0EMyK41V7hk2NsaY=;
        b=2AQA7CmLtVGaW+7WbU7vJd4GXORRPZsbo/jsS2OfkATqZmKsbgUmXOJ+iDAOqm4g8A
         S61qNCOkjjQ0kubtgAYM4/LpJvrtLlnx099GwdgQZqwlKEvyk0bxrmd2Nljpb4FAUhQD
         TFw+2UH8/X/hFBZzAEaAi9dXjcJtV+0ASkbutne7RNso52h+cpGWZ4U9Mjp9++EX9NKW
         iIt4/07FWDg3X+h7VgPdu9pN9kQXUO2mecT+B/1m0yux4CnhMsO8NWU8xJL/7Jq2f87A
         sITWEtle0WuHSrCOgxH7hInyl3MtISwwdGQj5tVK9RHsTjMWEtUTrEXHtDXIgC3f0esn
         pF2A==
X-Gm-Message-State: AOAM532BcPpJ+NKnw1Tw+I9fWZn5zwQ1MYfl+ws5Z7EvC9Md5CgX3Tum
        CGtG6QsHEeEMZHk35Fx0taw=
X-Google-Smtp-Source: ABdhPJxHcEarg8p7YxCErNj5Geoz6SfLjmlOsUYn7TqDYaETL4gT4YfGq1AF1vv7hwh1pbngh6yjBQ==
X-Received: by 2002:ac8:5685:0:b0:2ed:f44:49d3 with SMTP id h5-20020ac85685000000b002ed0f4449d3mr1919934qta.435.1649737096413;
        Mon, 11 Apr 2022 21:18:16 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id l21-20020a05620a211500b0069bf630f3b4sm5942431qkl.125.2022.04.11.21.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 21:18:15 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:18:13 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220412041813.GA2860081@jaehee-ThinkPad-X1-Extreme>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
 <Yk++AMDTu7LCbjHu@kroah.com>
 <20220408074424.6e862f3f@elisabeth>
 <2419031.jE0xQCEvom@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2419031.jE0xQCEvom@pc-42>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 04:07:12PM +0200, Jérôme Pouiller wrote:
> On Friday 8 April 2022 07:44:24 CEST Stefano Brivio wrote:
> > On Fri, 8 Apr 2022 06:45:52 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> > > >
> > > > [...]
> > > >
> > > > @@ -61,7 +63,6 @@ struct wfx_dev {
> > > >
> > > >  struct wfx_vif {
> > > >     struct wfx_dev             *wdev;
> > > > -   struct ieee80211_vif       *vif;
> > >
> > > You need to test this on real hardware.  For an outreachy-first-task,
> > > this is not a good one at all.
> > 
> > We discussed about this on the outreachy list, and I suggested, as
> > Jaehee also mentioned, that maybe somebody (Jérôme?) with the hardware
> > could give it a try.
> >
> > It looks a bit difficult but it also looks almost correctly done now. :)
> 
> Absolutely.
> 
> I will test it once the various comments will be fixed.
> 
> 
> -- 
> Jérôme Pouiller
> 
>
I just wanted to update and let you know that I mailed a new patch v3 just now.
Thanks!
