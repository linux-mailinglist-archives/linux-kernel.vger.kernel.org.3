Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FD590903
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHKXQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABF5C97C;
        Thu, 11 Aug 2022 16:16:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r22so15971936pgm.5;
        Thu, 11 Aug 2022 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cMOKYlcYTqw4MjWpy2PHg44DkbIdHSJMfu9lefA+Tg4=;
        b=I6p+8dV5qOBTOTFSUzQwQjQ21VUKsLNXKlvQlYBLa8lIkHhub/O+D8oBAuZ9GKOgeF
         fG+HyE1VpO0W8Mc4ciWPTKomDH9vpy/q+kxrhvCiwoGUv6lr8uVwq/HJTibXK9fxd2zi
         MwG0WQba2Kx4BlKQ2IONZG4o5q0/AQqnYQeCWJM7sdFGGtmPZ4ILzDCwcm+YRCZ49NFX
         ok9iI43wozqdDwqFYFfZLdq0DEu7hEe87Fxre6k+mgCB3jxLOI2wl7yWgqwQEQDr32rh
         mqGVyuvKIpWkjF0p4Wpg4wvIi8H7KzxAFbxN/BpTIL6s/A3nuqozT4oE0VNOO+bnPxcy
         wngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cMOKYlcYTqw4MjWpy2PHg44DkbIdHSJMfu9lefA+Tg4=;
        b=UN3R9V07An7M0cGhyiJsABF6cDKk+po+zUPmygUvKYBFQepC/63pfvE1pb1vLPHsNj
         pr7cb+JCDQPXWx4lQ+I8R0fxq+TMCyR6UWvWVbnOA5kh2dAya3Ll0rmwVFgQvYIymVXj
         m0dmlGg0d88wBkbRZ3nquoXDYxjpPAnNftm0yKSkvmjtxAELa04L0lM1wWOwdFo3id6G
         WSMRjLKoa1NdrgGq5OIHxr2Ju/h04wTQJklQlAXJBBd9TA9GrcM7X00t2a2PUfhAOWCI
         8BTnTQhf++p12/jwM3TdxzC2qjMcO4IK2rf4Kl3abQxuRF55L1nRsYExmA+UZ2FZW/DS
         H06g==
X-Gm-Message-State: ACgBeo2J5T3jY2KG/EIsAc3Yufmm9x2qvOjnk3nVyN+D/7xUTLz3hGZQ
        IiyXtZIyaMyZ5MVknkOGqKUvCnnrORw=
X-Google-Smtp-Source: AA6agR5CxOJ9QL20HMaZovY/TZhVpFFp7v8UT8RBOio+AIteD0hz5gzePzY5XWa5ljXEaR9eIJGkwQ==
X-Received: by 2002:a05:6a00:2195:b0:52e:6157:904d with SMTP id h21-20020a056a00219500b0052e6157904dmr1071533pfi.44.1660259774160;
        Thu, 11 Aug 2022 16:16:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b0016d2540c098sm197677plq.231.2022.08.11.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:16:13 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:16:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Input: bma150 - Fix a typo in some comments
Message-ID: <YvWNuiGYfZqYG39A@google.com>
References: <a331a6244a1dfbf34dc85f1be6995fa91500c801.1659802757.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a331a6244a1dfbf34dc85f1be6995fa91500c801.1659802757.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:20:32PM +0200, Christophe JAILLET wrote:
> Remove some extra '0'
> 
> s/BMA0150_RANGE_xxx/BMA150_RANGE_xxx/
> s/BMA0150_BW_xxx/BMA150_BW_xxx
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
