Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D54CB1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiCBWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiCBWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:06:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6254C9920;
        Wed,  2 Mar 2022 14:05:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so6005434pjb.3;
        Wed, 02 Mar 2022 14:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMJc6W7Kgv7ZyjMiiqL1FjMyScAu5V6JaPO0AS1Mq1A=;
        b=mqOugGmGSDs5PNIbOb8sTwuqCj8HekIpwssrTdhVlS6B6aASR2kzJRnjmYVThQjy6Y
         xWNPmuefiSKJY4vigJQAiJCSzewXXho6P4+lV1jRVRTBNIr80/NMLVPquwbleDJf9fYr
         gs95TSlfZaDcnXPvsqT3pSnqnNyznvs+n+74HWCCvG6UYvr/lL7Qncn8pLCcTNVmA8dN
         boz5z/HdloRalNqu+OjrMU3gRTf47D4Dt4L2XiItxJ0JBchGE5jBhKSjPfLf/3lzG1nV
         /FUFt1lxQWJmlqxy+i4vhZNZopE5wc2S/YUswznF4TDXLsgTnt0sYWBzILRRBXKdrfuh
         p1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMJc6W7Kgv7ZyjMiiqL1FjMyScAu5V6JaPO0AS1Mq1A=;
        b=EAmkgZsG/JhHhKLtlbwty61qVJaNIKYzWFJt3XW/zLdK3xQ+Ji08gEI++FbNlmCpm8
         raH7oWyZpeR7EvUH1ssqUF+7ESBSOh68djE2GAz602JbHDNqjd2IJ+s2i6pjcljBTBZL
         L2Q+i+gORHixMoxC3GCsyk4EZOKEr5bX0Unqg2vyBO9ZVWjv37QVuxJ0klk8B7kscaco
         iSMw/TIcRaR082gV8o2WrQCjstY/VPXon5cJZdp18AXdbbxtxBsauRaxsEIKsdl5J64K
         bnfwr3KzZqQkzEGKsEC9CbmZY29fHigPZZxJOwIDBBwueRCWbwPV4fVOfvPcaX/djHuR
         kZoA==
X-Gm-Message-State: AOAM531TtMgd2XcXSBUv06dfI8bNEqjfkenuwo7LfQ5PhAGCBMacG4iA
        9sJI3FffKA3q0Ev33hhkc5A=
X-Google-Smtp-Source: ABdhPJwLmoIylABfUeb/2aL7Qy3assVUhUW5MIksJhb0GyrxKN3QEW5JyL+tKa/0nqpvy/WGw/UNJg==
X-Received: by 2002:a17:90a:a594:b0:1bc:5def:a652 with SMTP id b20-20020a17090aa59400b001bc5defa652mr1932210pjq.167.1646258757343;
        Wed, 02 Mar 2022 14:05:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f1fc:2949:1f18:b6ff])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm137430pfg.165.2022.03.02.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:05:56 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:05:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: Add mapping for KEY_ALL_APPLICATIONS
Message-ID: <Yh/qQQcisY5s8WSI@google.com>
References: <20220218233350.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218233350.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:35:49PM +0000, William Mahon wrote:
> This patch adds a new key definition for KEY_ALL_APPLICATIONS
> which is an alias of KEY_DASHBOARD.
> 
> It also maps the 0x0c/0x2a2 usage code to KEY_ALL_APPLICATIONS.
> 
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
> 
>  drivers/hid/hid-input.c                | 2 ++
>  include/uapi/linux/input-event-codes.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index eccd89b5ea9f..c3e303c1d8d1 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
>  
> +		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
> +
>  		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
>  		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
>  		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 311a57f3e01a..e520f22c1b8d 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -279,6 +279,7 @@
>  #define KEY_PROG3		202
>  #define KEY_PROG4		203
>  #define KEY_DASHBOARD		204	/* AL Dashboard */
> +#define KEY_ALL_APPLICATIONS KEY_DASHBOARD

Could you please make KEY_ALL_APPLICATIONS primary definition and
KEY_DASHBOARD an alias and update hid-debug?

>  #define KEY_SUSPEND		205
>  #define KEY_CLOSE		206	/* AC Close */
>  #define KEY_PLAY		207
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 

Thanks.

-- 
Dmitry
