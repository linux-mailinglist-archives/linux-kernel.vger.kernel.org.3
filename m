Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C2958CC74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHHRAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiHHRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:00:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E012AC5;
        Mon,  8 Aug 2022 10:00:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so9070069pgc.12;
        Mon, 08 Aug 2022 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pFXf4ENRECsOAmoiHh0T/+VEFMiRgcffxnFkrnsYLEo=;
        b=RTK/PkxTJPZMsyYcFGiisEcaTkBui67WMrsSD1Qf5CJ9f5ubOiWHKAVrr9R+q6LabK
         rqO9TYwt/bXEMHPKEU+yH6Apu9jYk12hU+MjQtWFSDRHk/NmikXM2gtqJ42IBYbMxnLy
         WU2uCgcHHBuKDaQjsWI5WDGSF11mKQvHqwVYMOrzofZy8WuMT3OOciM+It3UhaYHzYzi
         JwuJKXmz2FmHeDOLHbf20z217rXBEPlk9Qa8cLONnxS1D6s37OrocVBxqkk5F6HcQqDJ
         3MknxANPTIch4oAJ1y/fm260Y5y9iFAG5yvKZl0QURDnGskq6rLDUGOYTfrcnCyXGBsH
         ckmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pFXf4ENRECsOAmoiHh0T/+VEFMiRgcffxnFkrnsYLEo=;
        b=O1Y7Vod6zcrsNXitHFkRwRFjQTxZDAb5OnQt1IiSTd3Nk1OpYRwhBoIUhRYEoVvdTc
         G1cdr501/acKMQlBHWwb+cAmTGJJ4QTQWkoVkIsfLIgL7MWhdadaQT/NZDavAFpoUrYY
         vSGu0fNSpBYfLhMfFNgOXs6wor8ql3DbqiAJph7xHVcdkD/QsMMkzSc3ShItBmYRL62E
         r/CW7cqcxtfGy8qOD5jZ1izo2WEAx4sUWRit0sCZw+crYu33Lkgp+i5t1zY2COpSYXuw
         LH+CfwOovDHPIluWpcyF9ynKfTQ0ALRxYlsBnepa1yeg+PbqV4qiNOU7/TKc3QBfJyi0
         li5Q==
X-Gm-Message-State: ACgBeo21wm4lzsOAtmcEWHbpYzijNpOIHID9qUSv+65168rvrVP59Opi
        XdA6cyatqIuygh3CG6NTOFmneH8/vg5F/g==
X-Google-Smtp-Source: AA6agR4l43+kMCG5UtmpxzCSuWUBw63mYch9j9LRqRAxZPZOxH3F43GIVe9q/wPSDbVatXnV1opRiQ==
X-Received: by 2002:a05:6a00:986:b0:52d:8c68:7b4 with SMTP id u6-20020a056a00098600b0052d8c6807b4mr19202996pfg.35.1659978010072;
        Mon, 08 Aug 2022 10:00:10 -0700 (PDT)
Received: from Mahakal ([2401:4900:36ab:9d3a:cf26:15dd:368e:8685])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm9282117plf.20.2022.08.08.10.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2022 10:00:09 -0700 (PDT)
Date:   Mon, 8 Aug 2022 22:30:02 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "inux-clk@vger.kernel.org" <inux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinmoyghosh2001@gmail.com" <chinmoyghosh2001@gmail.com>,
        "mintupatel89@gmail.com" <mintupatel89@gmail.com>,
        "vimal.kumar32@gmail.com" <vimal.kumar32@gmail.com>
Subject: Re: [PATCH] Common clock: =?utf-8?B?4oCL?= =?utf-8?B?4oCLVG8=?= list
 active consumers of clocks
Message-ID: <20220808170001.GB5239@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
 <20220622170219.GA6978@Mahakal>
 <20220624010550.582BBC341C7@smtp.kernel.org>
 <20220626182517.GA26001@Mahakal>
 <MW5PR84MB1842824E0F57D0EC46381B09AB9D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW5PR84MB1842824E0F57D0EC46381B09AB9D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:49:17PM +0000, Elliott, Robert (Servers) wrote:
> 
> 
> > -----Original Message-----
> > From: <Vishal Badole> <badolevishal1116@gmail.com>
> > Sent: Sunday, June 26, 2022 1:25 PM
> > To: Stephen Boyd <sboyd@kernel.org>; mturquette@baylibre.com; inux-
> > clk@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: chinmoyghosh2001@gmail.com; mintupatel89@gmail.com;
> > vimal.kumar32@gmail.com
> > Subject: Re: [PATCH] Common clock: ​​To list active consumers of clocks
> > 
> ...
> > We will remove above prints in the revised patch. We are facing
> > indentation issue whle printing consumer in summary
> > as given below
> >                                  enable  prepare  protect                            duty  hardware            per-user
> >   clock                          count    count    count        rateccuracy phase  cycle    enable  consumer   count
> >   clk_mcasp0_fixed                   0        0        0           24576000     0  50000         Y   
> >   deviceless        0
> 
> 
> Consider making the kernel output simple, greppable, and parseable (e.g.,
> comma-separated fields, one entry per line, no multi-line column headers)
> and let a userspace tool do the fancy formatting.
> 
> 
> 
>
Hi Robert,
We have raised another patch for the same. Please find the below link
for reference:

https://www.spinics.net/lists/kernel/msg4459705.html

Regards,
Vishal

