Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B07596ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiHQMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiHQMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:47:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79575895ED;
        Wed, 17 Aug 2022 05:47:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 2so717088pll.0;
        Wed, 17 Aug 2022 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=hflJ2ddAA0c59y69G6DHLCoY5J1cvr6VUWzXyUtIMkg=;
        b=DXO3Q8MCGcpgSq+uEaWCoiXi9FRhJpdOqY4BIs1SfJonamFIhtNi4i/YiuqxjIug3e
         eBgM5NPEAjTNfBOL4PtwlQe3JdW65sugBbWdHj6D7Gaa5wwkiuzCFNc6K1y+4Q5S8xQq
         BaeBrHuuxijPRTVLNjf99E/1GYmcoa2RY8yvFwpktarTAuvZHT0Hv0RnGWOeHTdWh1pu
         SLqBh068XQJGpBevNJD6vLx3bHm0StKP2oeYb5QTRTSAkjFDmF0P+g+4HSr3XaRZPJya
         nEvnVid+AVPhHMMij5wNhylbRZVxMynxMjNfQLkPDUZ+3uxRNAJasIdArhI8QP9k7L33
         zjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=hflJ2ddAA0c59y69G6DHLCoY5J1cvr6VUWzXyUtIMkg=;
        b=TX5nLAIKbd/wlX2fqFhEI+63U5xkOZfgGGpvmCpgc5OS+CQNKEoLfzQX+GJiSl1D1q
         5iAIoFlORWd2ydRPU9AzLgad13KpDxK4UTT7u+PAURp1PurpaWEivSZpLBUeqxUB/VkK
         moo9b5PA+raZc+uOvm6icehSB1TRdqVmWqwGqDCmQ6knvYN+ZqPrKKCkooPrwTlzwgFu
         3qO4uvfk9pvm3BSzreDJBcUkl2eTkzNm+4V6B+4xIM0Yf/IYP6Cf+KfM+n7wC6Qt78qy
         5nyXtOsMRyj38oZffgqGd32MEZCgorLE1plh83074zjFkZS7RGUvfk0hmcYV8rceo1CN
         AfbQ==
X-Gm-Message-State: ACgBeo3Jy1KZJgtcf3qRuVjy9weJQ6PiAeS9yu2WFvtD08yA5Nc7y5Fz
        zqCVdkPU5B6E6WbK6vodfjE=
X-Google-Smtp-Source: AA6agR72H8TWulsx3R39UT6AxKzsZDVs6y3FoQyHHE/v7FHHPgUvLXgcS2DMTH7pL33enO2ygv1s3w==
X-Received: by 2002:a17:902:e885:b0:16e:c85b:e3bd with SMTP id w5-20020a170902e88500b0016ec85be3bdmr26837449plg.63.1660740471924;
        Wed, 17 Aug 2022 05:47:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b0016ef87334aesm1316492plb.162.2022.08.17.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:47:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 Aug 2022 05:47:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Duke Du <dukedu83@gmail.com>, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fran.hsu@quantatw.com,
        charles.hsu@quantatw.com, george.hung@quantatw.com,
        duke.du@quantatw.com
Subject: Re: [PATCH v2] hwmon: Add the pmbus driver for the TEXAS TPS546D24
 Buck Converter.
Message-ID: <20220817124748.GA397124@roeck-us.net>
References: <1660718497-7315-1-git-send-email-Duke.Du@quantatw.com>
 <e9b97ea3-0867-d09f-ca59-362931073c9c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b97ea3-0867-d09f-ca59-362931073c9c@gmail.com>
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

On Wed, Aug 17, 2022 at 07:28:47PM +0700, Bagas Sanjaya wrote:
> On 8/17/22 13:41, Duke Du wrote:
> > make the PMBUS_VOUT_MODE return value 0x17,
> > VOUT returned value is linear11.
> > 
> > V2: Correct the tps546d24.rst format.
> > 
> > v1: Initial patchset.
> > 
> 
> Seems like the patch description is just the changelog, which
> should have been put between the dashes and diffstat. I would
> like to see the proper description.
> 
Same here. The description doesn't mean anything, should
be a comment in the code, and, yes, the change log should
not be part of the description but follow after '---'.

Guenter
