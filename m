Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB14E7D56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiCYT11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiCYT1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:17 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E261E5337
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:00:24 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y198so9316272vsy.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rethinkdatasolutions-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:importance:content-language;
        bh=/5UXv8V5r/HkNPnWWJTFfJIYhHVTZnd/ZthYxq3bFwk=;
        b=Mz9wugi12yJzTWhToAGLHBaO1/7FUJq7sU/7y5SwWIv8hNsQQKFBuDq6CFS3qzopxX
         RxpIA82jiBO/geB1xTyqeMSc4fnp8DwVSN1oPz9MVW5Oe0MMP+ENqW4P9inpWkH8V3Zr
         y4ayaa0hbgL0W2zLt5+DZJXGJ3JZvRnB+8rniB4C1S0ZrOIO2KCodpMxmULrsqqr7WqZ
         +WKeklreiUsq5EnXOIAiLfld2wpnYvwExB5XoBl4CKiosVxENE2+iODZILSMk0LV1xTl
         10bfZygpT0iEQxs8VCLVnaGVSeLaoVpVMPb1mbnVLQfl/Y/WBLfSNRIC588Y2xT2R022
         Vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :importance:content-language;
        bh=/5UXv8V5r/HkNPnWWJTFfJIYhHVTZnd/ZthYxq3bFwk=;
        b=MEk737pG+Y6ZJUzFY+jxxQpgV9sfaH3GMEQvNtd/5/Eh51KAzE69oHnYx8KLwCl0u/
         e74tHJXpQx2KVHgYLUbWpr/oqGUlHj19Z4iP4Cfcz1DXNYN40jKlOFoUy4CD1tsxwaSM
         uMdWGVY8aFXwVFGtXMMl+wDr3X/P4hck41nm2MZzRBopH17X4SJVsz9ROzAjx0/gbXZV
         wudr3r4B840ZKmerRlDDEd6lG03QGu0P+IhEVHCG5hGHzcovdLdwQk40h/Boku8dCXzy
         zfKGzkk2SuFiL44jLMyqbVa/n8TEtP00WwdRaelb5pZwHTBR5ERTjLoe/yRm8FpfAhLr
         qyzA==
X-Gm-Message-State: AOAM531s3R1SGKqUULTdQZmLWTperuPhhXRNmU8NoiIRbqCu5Hr7Ppdb
        EX+YbUo6EMFB38/u+p7arr4ieLdpXMH4FOKI
X-Google-Smtp-Source: ABdhPJyt8SxuCeZWyS1+JoszsNI3YPby2cwVkX5O0CbDEFowjMgK5nCJr3agfI8ZgPtnjKBt95y+6Q==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id o2-20020a170902bcc200b0014f23c6c8c5mr12749776pls.131.1648232745907;
        Fri, 25 Mar 2022 11:25:45 -0700 (PDT)
Received: from DESKTOP5NE5LE8 ([2406:7400:63:48d7:68d7:535b:49c8:ba2d])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a001c6300b004fb20b5d6c1sm1406705pfw.40.2022.03.25.11.25.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:25:45 -0700 (PDT)
From:   "Elizbeth Smith" <elizbeth@rethinkdatasolutions.com>
To:     "'Elizbeth Smith'" <elizbeth@rethinkdatasolutions.com>
References: 
In-Reply-To: 
Subject: RE: Gartner Security & Risk Management Summit 2022 Attendees Data List
Date:   Fri, 25 Mar 2022 13:24:31 -0500
Message-ID: <0b5a01d84075$be1247d0$3a36d770$@rethinkdatasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdhAc7yNzmr0P1BpSa6k3Qw8JtiWpAAAMkcAAAAADHAAABIAwAAAABIQAAAAEkAAAAANcAAAAAtA
Importance: High
Content-Language: en-us
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
Would you be interested in acquiring Gartner Security & Risk Management
Summit Attendees Data List?
 
List Includes:- Org Name, First Name, Last Name, Contact Job Title, Verified
Email Address, Website URL, Mailing Address, Phone Number, Fax Number,
Industry and many more.
 
No of Contacts:- 11,267 Opt in Contacts.
Cost                                :-$ 1,689
 
Looking forward for your response,
 
Kind Regards,
Elizbeth Smith
Marketing Coordinator


