Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577F598CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbiHRTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243724AbiHRTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:44:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EA35C372;
        Thu, 18 Aug 2022 12:44:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f21so2677473pjt.2;
        Thu, 18 Aug 2022 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=W5e17+6oMWWVgLvMfPt1qnfpuP7V0mz0KRYnC4cgIVo=;
        b=HpqQOsLa5ecdX7tYB3ulW6lzQI9ks3T2jeG4Kpym11YEQcQz4c+9sL7uJK/2hrw5tz
         ykan/swKvpwVrFhhUT2Cyyt9E5bFftqcbHZWreEYQazkNWx4HbeeM3lPvjXEqXAZxYAX
         TY2XQ1vYu5BwHBW0fPB4Vftlj3Jb9BZEMHVS5OjnbB/F/xv1SPNikfjZzDR1Pgsf7EHe
         3Z/KZhIYbsAN3H5IxHNH1K+zfdugfWswvP2wxKkHh6LaShRswPBaDfOSAoPlc59qAe/c
         eJqA40KOl4907vNgkZS/ID2Z4SFgm70OFpSkW4o4aKwMFDGnXuI2o0U/V7uKpDq4mXDS
         T5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=W5e17+6oMWWVgLvMfPt1qnfpuP7V0mz0KRYnC4cgIVo=;
        b=fpXP+G0x7nCw2svgAtKdcdvtoeG+FzGB6f4oLHuXXB7wMtvSXX54+hg7gcUi5Z+GxQ
         53qPzPvdjye79iLoj9ktVVH74NChVaLmX/JW346HAHtNnS+0qbmh9oTZf6hXdgnLx57i
         uEcw9U+OSC0yohTylLK3Ey5RlLcEFqyUE7wI8BgesM3ubqW5Aa92+CE21qOhoXd9/sKq
         00/X9xIYlzUmxG4o+92aLqcOa6gGrWtPolqRWI6SjqLtuELhWYFwO8JLvy+d51Nm2VQ/
         YWoBBLmWJ32FegPNsT6nH5wLegLvVnio83DAQ8Lot+MRzSkBKLNlQdQm17Z7W2oPHAsz
         7dKQ==
X-Gm-Message-State: ACgBeo24Y4Zxp6L+KKMoGqaBrVdiPiUGVy+Pdx3yDViPd2dAK3ycfj12
        MwsmD6Vtw1JVC+FiEXdXp1c=
X-Google-Smtp-Source: AA6agR5eZF5pR7nr99GV0b64Rd0OjCavWMRpEiftpGEjOFlcRq1OF0Q7+E5NJ379ZDa13a9N0J1+1A==
X-Received: by 2002:a17:902:cf4c:b0:170:5b7a:8f89 with SMTP id e12-20020a170902cf4c00b001705b7a8f89mr3816249plg.121.1660851881184;
        Thu, 18 Aug 2022 12:44:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b0016f1aa00abbsm1772297plg.195.2022.08.18.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:44:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 12:44:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 02/16] hwmon: (mr75203) update pvt->v_num to the
 actual number of used sensors
Message-ID: <20220818194438.GA3216536@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-3-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-3-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:43:07AM +0000, Eliav Farber wrote:
> This issue is relevant when intel,vm-map is set, and defines a lower
> number of VMs than actually supported.
> 
> This change is needed for all places that use pvt->v_num later on in the
> code.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 0e29877a1a9c..f89f7bb5d698 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -605,6 +605,7 @@ static int mr75203_probe(struct platform_device *pdev)
>  					break;
>  
>  			vm_num = i;
> +			pvt->v_num = i;

This code is changed to no longer set pvt->v_num in the previous patch.
Do not send patches which fix issues introduced in an earlier patch of
the same series. Besides, again, regarding "when intel,vm-map is set":
That is not an optional property.

Guenter

>  		}
>  
>  		in_config = devm_kcalloc(dev, vm_num + 1,
