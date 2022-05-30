Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC51537509
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiE3GzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiE3GzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:55:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD96F49E;
        Sun, 29 May 2022 23:54:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q21so2073368wra.2;
        Sun, 29 May 2022 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7syxmBySjwfnHsIvdxxYLTq0FodLAYaXUi0vCyeTbo=;
        b=ZVeQQHIRZEVyIZ2oDkMq7XjD88sBia2B4KKm0khujXyy1SJbYkLjolBCYHMfdpS/yF
         Cz2oBl6Ktz+Iw910Y42S5exUzCwJ9dHsLE1foeiLIsFTMIhsJOtvsmXLsyTiZVaZPKcM
         Rvfi+uSLzmuLD7W8m6+vR86ez233fAQW1LQSgF24FCjIi247//6mMXdt2Inj915N7vT1
         AoFmN1nVOSB3Lo0YkVKVqRS+gz5FO8zAk6dKvQcXzamdRHfaJHcGXWV60244gWTjL2ME
         ZsrPBDo6pfCR5GV5vELfdYgePC39rzjk+SsiFUZgLL9rpn5CX1OKfPagR0BClUvPl+Er
         xOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7syxmBySjwfnHsIvdxxYLTq0FodLAYaXUi0vCyeTbo=;
        b=NiI3eBWx0FFtm3ikfalvm3+lgx7A9B43jdzcEpd1S2PkDodOoPhpuHUVp5004Auvo9
         5P3M86LDqJaRgtvAGxbXSBeauA3WzHWGD4mfYzgwZN4v3dUeMzRTJIVPtwKcJrhEsUux
         jTxhs+vLz0Gtw9BfokSk8SBVCQRiSJQkew9RTl44eENAI45zbLCmdkNbj7qHZHOBpqvo
         LMuGmEyMaBT89UM6GtodtjjxqP2oatoHgmOpGilL62xIWLvbA784i8ocvVWkHqEsE+wY
         ZXhjhFe8w07y1jm8KFxFa91PQ1DmdM788rQzZkg3bzTYnNRddUjKIi9/V95uS2mXyJFU
         bxpA==
X-Gm-Message-State: AOAM5330NmB3m1p8+xPiMpkjp2zIKcLWAJV9k/fcSpK/CMaUAtEVD2tz
        E3iMyAiqnmuTPToMW5vWSLFO3kAym7M=
X-Google-Smtp-Source: ABdhPJyBegUWfRpIAV1MtGnjhf15IxbEt8TghdtXx85rZhob+LmL0OtrFj8DwZ8fSxzHIG8gFm1Xcg==
X-Received: by 2002:a5d:4886:0:b0:20d:527:f98b with SMTP id g6-20020a5d4886000000b0020d0527f98bmr45849795wrq.70.1653893697657;
        Sun, 29 May 2022 23:54:57 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b0039c151298b7sm499327wmb.10.2022.05.29.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 23:54:57 -0700 (PDT)
Date:   Mon, 30 May 2022 08:54:52 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.19/uclogic] HID: uclogic: Remove useless loop
Message-ID: <20220530065452.GA39613@elementary>
References: <20220518224702.1409327-1-jose.exposito89@gmail.com>
 <20220518224702.1409327-4-jose.exposito89@gmail.com>
 <17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thanks for the patch. You can send it as an standalone patch rather
than as a response to my patches, I don't know if it could be missed by
maintaners this way.

On Sun, May 29, 2022 at 11:49:46PM +0200, Stefan Berzl wrote:
> The while in question does nothing except provide the possibility
> to have an infinite loop in case the subreport id is actually the same
> as the pen id.
> 
> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
> 
> ---
>  drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> index c0fe66e50c58..1a6b941f3964 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -423,40 +423,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
>  	if (report->type != HID_INPUT_REPORT)
>  		return 0;
>  
> -	while (true) {
> -		/* Tweak pen reports, if necessary */
> -		if ((report_id == params->pen.id) && (size >= 2)) {
> -			subreport_list_end =
> -				params->pen.subreport_list +
> -				ARRAY_SIZE(params->pen.subreport_list);
> -			/* Try to match a subreport */
> -			for (subreport = params->pen.subreport_list;
> -			     subreport < subreport_list_end; subreport++) {
> -				if (subreport->value != 0 &&
> -				    subreport->value == data[1]) {
> -					break;
> -				}
> -			}
> -			/* If a subreport matched */
> -			if (subreport < subreport_list_end) {
> -				/* Change to subreport ID, and restart */
> -				report_id = data[0] = subreport->id;
> -				continue;

Here, in the previous code, the "report_id" is set to the subreport ID
and the while loop is executed again with the new ID. The loop acts as
a recursive function.

Isn't this behaviour removed by your patch?

Jose

> -			} else {
> -				return uclogic_raw_event_pen(drvdata, data, size);
> +	/* Tweak pen reports, if necessary */
> +	if ((report_id == params->pen.id) && (size >= 2)) {
> +		subreport_list_end =
> +			params->pen.subreport_list +
> +			ARRAY_SIZE(params->pen.subreport_list);
> +		/* Try to match a subreport */
> +		for (subreport = params->pen.subreport_list;
> +		     subreport < subreport_list_end; subreport++) {
> +			if (subreport->value != 0 &&
> +			    subreport->value == data[1]) {
> +				break;
>  			}
>  		}
> -
> -		/* Tweak frame control reports, if necessary */
> -		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> -			if (report_id == params->frame_list[i].id) {
> -				return uclogic_raw_event_frame(
> -					drvdata, &params->frame_list[i],
> -					data, size);
> -			}
> +		/* If a subreport matched */
> +		if (subreport < subreport_list_end) {
> +			/* Change to subreport ID, and restart */
> +			report_id = data[0] = subreport->id;
> +		} else {
> +			return uclogic_raw_event_pen(drvdata, data, size);
>  		}
> +	}
>  
> -		break;
> +	/* Tweak frame control reports, if necessary */
> +	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> +		if (report_id == params->frame_list[i].id) {
> +			return uclogic_raw_event_frame(
> +				drvdata, &params->frame_list[i],
> +				data, size);
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.36.1
> 
> 
