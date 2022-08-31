Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD55A8931
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiHaWrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHaWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:47:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568ED91E8;
        Wed, 31 Aug 2022 15:47:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so692746pjj.4;
        Wed, 31 Aug 2022 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iay2nTADW/kUUvtWoldUQXuwD/3nlsLf9V80OCJiJLI=;
        b=hZutgwD4GK/V8NLKS9krnIcxP2jENNhR7QGYI/T2VaUR7/d33a3nt3PAUPJkIhl1xE
         nzI2dsRhziyVEH6hT/cgRX2+o+RIE7++PzrMZO/BCnllVPmwy+IUGvCAscDZqm09NAaz
         8V58UKGgozXKbSPrCPrqGKJhrb1i0t+JGiWKdl1YvN+/WKckuc+qBbrbVGkqlggETrIa
         phlzwEeNmVPGg5GxFgMW7y4a8ihtQf5bs8kq3Y1Szt54dJcQ4OcN6Stv20cMCid5BMWC
         O9XF+Zd7MqEGMVFpNgv+W/CRDFzAkNnNF5YR/WgMUZVeOwKav97mODZ1jnNIEBXLefQy
         sRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iay2nTADW/kUUvtWoldUQXuwD/3nlsLf9V80OCJiJLI=;
        b=YN1/GY1FvKf0r3aNUWIRfZOshVZj9ePnvRvDiWF9bDEAgP6x3/zLL0kMFb9LdJj2W0
         XoD8poNFL0BuRYS20osKnOG7spxVS67tiLNk7mgLRlM5w000L8/XPOTzwEJn2c+3ULmo
         ODmd7c8/JJQfXRUve7rYrdawvd+ch397bmJrH4bmG52xof+v/zcBnuIC2cC081bkK2rD
         O8sIQ5AAksP5Ir34twQRFtNve9WyFsaDXYcV444e10kjUrLfOaplugE20VEQ0M7c0C/2
         H+hd6pnEekARCMwrfXo+V9/5XP50RdUcJyYvouHO+fysCrLHr7/Tmwg2SCXzIUs6se0w
         9VWg==
X-Gm-Message-State: ACgBeo1WoiR5m9FDdq9JB3toW4jUD883I3o0RqTu7mSPX4TY+pXLWWCF
        SjGa3LINi0OXdu/hzeN322c=
X-Google-Smtp-Source: AA6agR54FyZbckIsA6ua1C1jgjT8E5vioFthp7UlRA+c5odx3CPsXpoBYZGwGegpmJl0Ki+JlptATQ==
X-Received: by 2002:a17:90b:3810:b0:1fd:d001:ed41 with SMTP id mq16-20020a17090b381000b001fdd001ed41mr5343286pjb.209.1661986063000;
        Wed, 31 Aug 2022 15:47:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:45ee:d53e:4a22:630d])
        by smtp.gmail.com with ESMTPSA id n13-20020a6563cd000000b00428c216467csm3860898pgv.32.2022.08.31.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:47:42 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:47:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 3/3] input: misc: rt5120: Add power key support
Message-ID: <Yw/lC9rjnbFW3ORC@google.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
 <1660100142-32493-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660100142-32493-4-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiYuan,

On Wed, Aug 10, 2022 at 10:55:42AM +0800, cy_huang wrote:
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT5120 power key driver");
> +MODULE_LICENSE("GPL v2");

I changed this to be simply "GPL" (per checkpatch.pl, see commit
'bf7fbeeae6db module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
bogosity' for details) + did a couple of minor edits, and applied, thank
you.

-- 
Dmitry
