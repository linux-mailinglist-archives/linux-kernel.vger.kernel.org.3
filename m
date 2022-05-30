Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7253864B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiE3Qqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiE3Qqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:46:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC965C5;
        Mon, 30 May 2022 09:46:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so15443873wra.4;
        Mon, 30 May 2022 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FZ+c1abWjPnmUNxflevPIbZKJr1GuBxGqcGlWpgKpvA=;
        b=NxN6+WusRz0+JZXCENiMN76rf48G4ffcLF42NZaBHJVnlQKAf5qpHhXTsHS/Kcf7R4
         YS9a+3S64dnSkW+1xZG7cDDV+/hscOq9WAAUfdB8JcHOs1ZiKcW1QpDAVoNXE1fNW53l
         WCnHBxVAhrUXsYFWHimGQtrFz7THdYykOlxZuxMH9g4rmtxIWQIqiEE1Puw8RUrW8U7t
         haRFfd9ltsdfrOY/1RN8UGfuLcbfsmhOcigfK96N4tvnx7J1W9sKJEe1D+2SRi7tyfD2
         p3ukiB8iR8fA7Uak6/M70fYGoKu2B9xpgs2hB/EnWFOlDPCIA6tf5HIVftBwJd30Xs5S
         nmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FZ+c1abWjPnmUNxflevPIbZKJr1GuBxGqcGlWpgKpvA=;
        b=kjIxd4ABt/sElgBG/txSfW5WBj8xvNq1fIpMPLz3LA6B2hc6HNgM3gsj2FfbjcH5S7
         UfmDafIKEOq791/Rv81vs1CTYcgmrzvdYQk9v0edblGZo+dSA2H2+YUYlYgfVpcf3Hvo
         oNdohA3VPSEI8/sep9cog0FC9JJTGpqjtsUhg9TPPHt9BI+ufvHneAVurSxNi8T9CI6k
         6AMfYu/2Ts3wsZjMpICzll8G94RbVszA0r7WerDKpPcKYBItlEn9IvlcHtOb1EqIiLyF
         n25NkmjjDoCQ393hbeCsIM6yn0pbjrZ5I8+JwjcRxVI4A4tJ2xBHq4QMVek29iB0E5WX
         rSVQ==
X-Gm-Message-State: AOAM533RFjVkMC564hZ/yafCqNqcd3iykjU8IpXsZyY4upD3HrIMcL6e
        g6mwxbIK9op3gaGqesEdqDyoi2AJ1ofE4A==
X-Google-Smtp-Source: ABdhPJxfzR/nao0Sklrf9ey+ubpyRMeiAh0hZ6KgtyXDEZ38KbdQlOxsL9J6KDGBtuKUNdXcTzPVEA==
X-Received: by 2002:adf:e7cf:0:b0:210:3e5:32f3 with SMTP id e15-20020adfe7cf000000b0021003e532f3mr20480864wrn.509.1653929201681;
        Mon, 30 May 2022 09:46:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003942a244ee6sm10417538wml.43.2022.05.30.09.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 09:46:40 -0700 (PDT)
Message-ID: <a402fa65-e575-6c8d-90ff-c404143d947b@gmail.com>
Date:   Mon, 30 May 2022 18:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-5.19/uclogic] HID: uclogic: Remove useless loop
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220518224702.1409327-1-jose.exposito89@gmail.com>
 <20220518224702.1409327-4-jose.exposito89@gmail.com>
 <17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com>
 <20220530065452.GA39613@elementary>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <20220530065452.GA39613@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everynyan!

> Hi Stefan,
> 
> Thanks for the patch. You can send it as an standalone patch rather
> than as a response to my patches, I don't know if it could be missed by
> maintaners this way.

You are right about that, I'll keep it in mind. But for consistency,
I think it's better to reply here for now.

>> The while in question does nothing except provide the possibility
>> to have an infinite loop in case the subreport id is actually the same
>> as the pen id.
>>
>> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
>>
>> ---
>>  drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
>> index c0fe66e50c58..1a6b941f3964 100644
>> --- a/drivers/hid/hid-uclogic-core.c
>> +++ b/drivers/hid/hid-uclogic-core.c
>> @@ -423,40 +423,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
>>  	if (report->type != HID_INPUT_REPORT)
>>  		return 0;
>>  
>> -	while (true) {
>> -		/* Tweak pen reports, if necessary */
>> -		if ((report_id == params->pen.id) && (size >= 2)) {
>> -			subreport_list_end =
>> -				params->pen.subreport_list +
>> -				ARRAY_SIZE(params->pen.subreport_list);
>> -			/* Try to match a subreport */
>> -			for (subreport = params->pen.subreport_list;
>> -			     subreport < subreport_list_end; subreport++) {
>> -				if (subreport->value != 0 &&
>> -				    subreport->value == data[1]) {
>> -					break;
>> -				}
>> -			}
>> -			/* If a subreport matched */
>> -			if (subreport < subreport_list_end) {
>> -				/* Change to subreport ID, and restart */
>> -				report_id = data[0] = subreport->id;
>> -				continue;
> 
> Here, in the previous code, the "report_id" is set to the subreport ID
> and the while loop is executed again with the new ID. The loop acts as
> a recursive function.
> 
> Isn't this behaviour removed by your patch?
> 
> Jose

Think about what this behavior really achieves. In the first iteration,
we check if params->pen.id equals the report_id, which is the actual
report id from the usb message. If that is the case, we check if the
second byte of the message is such that we need an updated "subreport"
for this particular message. Therefore, the report_id is set to the
subreport->id. This subreport->id is by design supposed to be different
from the original params->pen.id, because otherwise, why would we need  
this update? If we then "continue" with this useless loop, either one of
two cases can happen:

The best case is that the (report_id = subreport->id) != params->pen.id 
in which case the if-block won't be executed and we only wasted time.

If the (report_id = subreport->id) == params->pen.id however, things get
interesting. The "subreport_list_end" and "subreport" variables will
again be set to entries based on "params->pen.subreport_list", which is
totally unchanged from the last iteration. We will iterate the same
subreports, find the same result, set report_id to the same
subreport->id and, that's the beauty of it, "continue" this ingenious
loop, creating an infinite loop.

This contraption is in the best case only wasteful, yet it has been
accepted all willy-nilly like. Really gets the noggin joggin.

> 
>> -			} else {
>> -				return uclogic_raw_event_pen(drvdata, data, size);
>> +	/* Tweak pen reports, if necessary */
>> +	if ((report_id == params->pen.id) && (size >= 2)) {
>> +		subreport_list_end =
>> +			params->pen.subreport_list +
>> +			ARRAY_SIZE(params->pen.subreport_list);
>> +		/* Try to match a subreport */
>> +		for (subreport = params->pen.subreport_list;
>> +		     subreport < subreport_list_end; subreport++) {
>> +			if (subreport->value != 0 &&
>> +			    subreport->value == data[1]) {
>> +				break;
>>  			}
>>  		}
>> -
>> -		/* Tweak frame control reports, if necessary */
>> -		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
>> -			if (report_id == params->frame_list[i].id) {
>> -				return uclogic_raw_event_frame(
>> -					drvdata, &params->frame_list[i],
>> -					data, size);
>> -			}
>> +		/* If a subreport matched */
>> +		if (subreport < subreport_list_end) {
>> +			/* Change to subreport ID, and restart */
>> +			report_id = data[0] = subreport->id;
>> +		} else {
>> +			return uclogic_raw_event_pen(drvdata, data, size);
>>  		}
>> +	}
>>  
>> -		break;
>> +	/* Tweak frame control reports, if necessary */
>> +	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
>> +		if (report_id == params->frame_list[i].id) {
>> +			return uclogic_raw_event_frame(
>> +				drvdata, &params->frame_list[i],
>> +				data, size);
>> +		}
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.36.1
>>
>>

Bye bye

Stefan Berzl
