Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC15386CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiE3RdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiE3RdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:33:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0A6898D;
        Mon, 30 May 2022 10:33:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso8850905wmh.3;
        Mon, 30 May 2022 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tYKbvG76LA1PzZXxEpBfJ7eVNQlA+wHk8noD9+5QRcY=;
        b=UdynqQUxRJ1fDl3QUggk+M5AMkTQEnOBLbmAomgTgwHkLfLH/tH8aBhzD97L+51gmg
         WBPtFL069BXZ3P7rc7i81ZRQ3cSkTzOxjPzasProhwc//C2YgJ+F3K1x+IdzNot18NdW
         x+BZSwWceyuRhAAa3KWo0r3KLA4XcTEBrMbn0at5y1BtOz+2lYuW8LXuyQ2xbfdzZQ2P
         yrijYyhSrmSXEXqEzv7YsoJVaY2UcAVdwv2SjjC6fRhEVaPD6NGdC3FJqGYl/+VcuiiW
         sUtRs+sHLehWwuR1jdr3sAsLxqZS8cqXYgkgqr7q/Rluej4f7XqcUHGLrEpJMjQWcWXa
         EbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYKbvG76LA1PzZXxEpBfJ7eVNQlA+wHk8noD9+5QRcY=;
        b=XZqA4n9xe3e6S4CXYIMisdqkZQ/KZP4mpb3Df3Ht+J+HTnZsGh7gqDGLOGssnjSQsk
         PhD/AaWr8TP22mlJjis2nF2rPQ3xfLxNVKrx1iCh/HTd71d3Mstykw4VZjlZVsBDIBlf
         WuM1bskKxULYX6Xv6g5uzoDwMPq2Qx2SG+CNaPJeLpEe6LsBSn9q4qM3VMSHAXMbsbQG
         cmE/8VtUwvAHR0TQweNTfX4n/h3Qg1pGxVsBq2VSkS30w6cQ8is+H2cLWR3qULMad1l9
         AKBJHoZtJVsDYYE8OddtAgHtGH0Sd38DM6XQCxd/Blo+dChhAgoBt/eGiVW1EjX/fAT9
         z9XA==
X-Gm-Message-State: AOAM532no0IMuBoP1bsYEUmUIkN6XJgvdywX9PEqXfsIGgsoL+yi0hUB
        ZI/Zvx5AiFNZLnj8tl1vLFU=
X-Google-Smtp-Source: ABdhPJz4akxuw9N90m3mFa+51/j07/0ptlnoxAgrSA26K9xQqU0dU5VX2Ycm6UBn1uZKS+XoHiIA7Q==
X-Received: by 2002:a05:600c:4e50:b0:39c:eeb:dabe with SMTP id e16-20020a05600c4e5000b0039c0eebdabemr6300405wmq.190.1653931991883;
        Mon, 30 May 2022 10:33:11 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003973435c517sm11613799wma.0.2022.05.30.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 10:33:11 -0700 (PDT)
Date:   Mon, 30 May 2022 19:33:06 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.19/uclogic] HID: uclogic: Remove useless loop
Message-ID: <20220530173306.GA20330@elementary>
References: <20220518224702.1409327-1-jose.exposito89@gmail.com>
 <20220518224702.1409327-4-jose.exposito89@gmail.com>
 <17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com>
 <20220530065452.GA39613@elementary>
 <a402fa65-e575-6c8d-90ff-c404143d947b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a402fa65-e575-6c8d-90ff-c404143d947b@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 06:46:38PM +0200, Stefan Berzl wrote:
> Think about what this behavior really achieves. In the first iteration,
> we check if params->pen.id equals the report_id, which is the actual
> report id from the usb message. If that is the case, we check if the
> second byte of the message is such that we need an updated "subreport"
> for this particular message. Therefore, the report_id is set to the
> subreport->id. This subreport->id is by design supposed to be different
> from the original params->pen.id, because otherwise, why would we need  
> this update? If we then "continue" with this useless loop, either one of
> two cases can happen:
> 
> The best case is that the (report_id = subreport->id) != params->pen.id 
> in which case the if-block won't be executed and we only wasted time.
> 
> If the (report_id = subreport->id) == params->pen.id however, things get
> interesting. The "subreport_list_end" and "subreport" variables will
> again be set to entries based on "params->pen.subreport_list", which is
> totally unchanged from the last iteration. We will iterate the same
> subreports, find the same result, set report_id to the same
> subreport->id and, that's the beauty of it, "continue" this ingenious
> loop, creating an infinite loop.

True, data[1] doesn't change, so an extra if is executed for no reason.
I mean, it is not dramatic, but I guess the while loop could be removed
for clarity.

I wonder why it was implemented in a loop though, check commit
8b013098be ("HID: uclogic: Replace pen_frame_flag with subreport_list").

The while loop is intrudeced there and I can imagine that for a good
reason... However, I can not think in a case where removing the loop
could cause issues.

> This contraption is in the best case only wasteful, yet it has been
> accepted all willy-nilly like. Really gets the noggin joggin.
> 
> > 
> >> -			} else {
> >> -				return uclogic_raw_event_pen(drvdata, data, size);
> >> +	/* Tweak pen reports, if necessary */
> >> +	if ((report_id == params->pen.id) && (size >= 2)) {
> >> +		subreport_list_end =
> >> +			params->pen.subreport_list +
> >> +			ARRAY_SIZE(params->pen.subreport_list);
> >> +		/* Try to match a subreport */
> >> +		for (subreport = params->pen.subreport_list;
> >> +		     subreport < subreport_list_end; subreport++) {
> >> +			if (subreport->value != 0 &&
> >> +			    subreport->value == data[1]) {
> >> +				break;
> >>  			}
> >>  		}
> >> -
> >> -		/* Tweak frame control reports, if necessary */
> >> -		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> >> -			if (report_id == params->frame_list[i].id) {
> >> -				return uclogic_raw_event_frame(
> >> -					drvdata, &params->frame_list[i],
> >> -					data, size);
> >> -			}
> >> +		/* If a subreport matched */
> >> +		if (subreport < subreport_list_end) {
> >> +			/* Change to subreport ID, and restart */
> >> +			report_id = data[0] = subreport->id;
> >> +		} else {
> >> +			return uclogic_raw_event_pen(drvdata, data, size);
> >>  		}
> >> +	}
> >>  
> >> -		break;
> >> +	/* Tweak frame control reports, if necessary */
> >> +	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> >> +		if (report_id == params->frame_list[i].id) {
> >> +			return uclogic_raw_event_frame(
> >> +				drvdata, &params->frame_list[i],
> >> +				data, size);
> >> +		}
> >>  	}
> >>  
> >>  	return 0;
> >> -- 
> >> 2.36.1
> >>
> >>
> 
> Bye bye
> 
> Stefan Berzl
