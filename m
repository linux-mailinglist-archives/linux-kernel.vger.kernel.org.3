Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898E35A1841
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiHYSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiHYSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:02:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECBBCC2E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:02:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l3so1143126plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fJGUNeVle9qIpaakWxtZxkW5gSPVt+D2sQZmSrc7TA0=;
        b=oengml8Fa9j59y9yWSmjkxR81+UYyoViuvtrfcnVuJh8ACXlyCYukM8Pp4cMAFNZ+L
         e/JOM7rSu42VUq5KndusGcP4dW6FpitIMI/bQ/jJevbikwZUWydWJIN581Le1+W8XOFd
         kvWL2eftehGMlCsNpWpmBmnAkTUrPn0jZblCiGM6vw8wDlxfYUIX4VHFMj6mkFmxweXA
         8wvMkZUAQhOsoONNKH78LzyLMiOHLjydO/alV1C0HdCKTiuUOvondOT2G5j70JtqM3Om
         LI4zvr1YTjBs0zwYkLGMfqrX/uwnxxOW0eEzw8TMLhHLVq6+5DwjQHibp6d0KHmQcXEc
         nKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fJGUNeVle9qIpaakWxtZxkW5gSPVt+D2sQZmSrc7TA0=;
        b=qJBZZWg5iFKFN9LvwhgMpipZwNGnR7IkV+q7QipwkDFHdKkk2O5KovpMncjNwwoujC
         NgahHIatxzjpAl2Uht983xiPJvK1WwFwJquM55E5oMKnmwv0csQEKLcOz7tSjYBwj5XU
         80noecvH4438W6n8+qSTuxMU9yPRXuvjuSSDcvW9bPdZDA4IEaWmv+VG1M4R5KcdobPJ
         SE/CVCx+CLEo18ZGL1gjjHDGqKsL/2N6WAe5+hX+nd/+YZ/TBfNj0xzw1zX7J03U0h2g
         QLxHy3c1JjcVDGv4CZa5rfuBq+VWvLDgw7p/qynTOjbrVjJtPKVcK3g0kLnduCFSaPek
         LBVQ==
X-Gm-Message-State: ACgBeo1Kyj+b/S1wEdeDo/fh+UP2nFAU0S2hNcafhtoo38zy+CmtsKTS
        8xGI+Df/AZ2EDl5pCjqsFjg=
X-Google-Smtp-Source: AA6agR6m4fwczP0E+SNqMtL/4nYaQsgnUK6fVOmRYOvBR0wpEkmzIfu8clnTc6MFQzLfYDxu5z2gwA==
X-Received: by 2002:a17:903:2c5:b0:172:d1f2:401d with SMTP id s5-20020a17090302c500b00172d1f2401dmr286243plk.56.1661450575837;
        Thu, 25 Aug 2022 11:02:55 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0016dc6243bb2sm15152565plr.143.2022.08.25.11.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:02:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 Aug 2022 08:02:54 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     "Xue, Zhan" <zhan.xue@intel.com>
Cc:     "florian@mickler.org" <florian@mickler.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regarding WQ_MEM_RECLAIM
Message-ID: <Ywe5TlXr2cR3inuG@slm.duckdns.org>
References: <PH0PR11MB50451B7F2F155AD8A893E9E894709@PH0PR11MB5045.namprd11.prod.outlook.com>
 <YwUb8UmXvKNHgSrP@slm.duckdns.org>
 <PH0PR11MB5045D2FF3C98EAE995F7897194739@PH0PR11MB5045.namprd11.prod.outlook.com>
 <PH0PR11MB50456E21C95359B57223F23994739@PH0PR11MB5045.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB50456E21C95359B57223F23994739@PH0PR11MB5045.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:10:56AM +0000, Xue, Zhan wrote:
> Convert to plain text..

The email's formatting is too painful to reply directly.

Here are two brief points:

* Just don't share the same workqueue between work items which need forward
  progress guarantee and ones which don't.

* If something can block memory reclaim, it is in the memory reclaim path by
  definition.

Thanks.

-- 
tejun
