Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77A54812C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiFMICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiFMICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:02:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1610571;
        Mon, 13 Jun 2022 01:01:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so5083421pfb.4;
        Mon, 13 Jun 2022 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZWzCgoz5Pw3mHE8/DxjotUDMmE2UXTU9cjooBfPmLk=;
        b=eYnjniZGIG1VbbkLc4H+4pxr7II/uiE5QUzdgkk8FjDZim7NHyrkQaJACWgS+VT8J/
         N5Hazh+NsG4Oq6jkk2ceOx9DRm9kGRi0VAETwfc1VwRKLZGgtxzXnryl+FH3Csi1/Vhi
         MU2rNA0bHK+/2q0S+XuWJfQYCebTP3WfWuKhmbYftBGxTqbOjUG3AoOw9mdzb1r7S1cj
         kZ344qTwXUNRPCMkVVlAJ8z8Sfv20pIkaQbHpimRpisj1ytbPTubIjjjHhzi66C+u/N/
         /U7pGptATCd5hcBargfGFbrwwijj5CyEYQPwC9w76XPpKybYxUTlrxUiMPOpWKtzrBT1
         6SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZWzCgoz5Pw3mHE8/DxjotUDMmE2UXTU9cjooBfPmLk=;
        b=MDcfN/2qO7Jqe5mVhJhnzwQvEbgBl/DK4PnwFBqFqIHab/HfdDL8DDAyxmKnTv64fB
         cbgcr2T0BzWsfCYd6VBzON7V8Z9myB9yJR8yPMTbBHeR5IHGBH4lu+BSSsltu8MtLI7F
         KGQq3yiX/+QJ4FER/nuzIngRzWfI5Coswsy9V3IqdyhEWzFL/8gIH6K3HkVfReu/1A7h
         4E06j1wQ/9Pzm2ctQG8+a5f769GE2Gxqyup78spPSAl0C3JfcYUl1VPBT6Pa0N35dRQK
         w8r7ARWC7PN9vCkvWOmcgxl66dkg41H2j0XF0LYu72zNfkdhjypdXG0vu45SwQtLK7q/
         KTew==
X-Gm-Message-State: AOAM531bQTzotaWYwfhrncm3JGAvn4rCZBGWh47nznO5q8OCBvvxaFZX
        8To9SF80pKBARdl5rC5y/zA=
X-Google-Smtp-Source: ABdhPJwip/iwh/bSl3Xq0RGH3xDHwUGJhANIMKdhvlGRKZdAtKJT95PIzG2rrw6Rb18tgoNsZDtDBg==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr22192430pfh.53.1655107317114;
        Mon, 13 Jun 2022 01:01:57 -0700 (PDT)
Received: from localhost (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b0015e8d4eb22csm4386153plb.118.2022.06.13.01.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:01:56 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:01:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>,
        Dongliang Mu <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev-tools: fix one invalid url
Message-ID: <Yqbu8TwmaXdBiIBs@debian.me>
References: <20220613071243.12961-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613071243.12961-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Fix the invalid url about Semantic Patch Language
> 

I think what this patch doing is to point SPL reference URL from old
Coccinelle documentation (doc root) to actual SPL doc entry on new
Coccinelle page, right? If so, "fix invalid URL" may not be right patch
description and title.

-- 
An old man doll... just what I always wanted! - Clara
