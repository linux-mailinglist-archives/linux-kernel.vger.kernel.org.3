Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34EE59A883
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiHSWSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHSWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:18:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FADC25
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso1822137pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=BcAPABzciTIGP2cxF54N2Wsd/iSJnRwhaMTJUEPlID3X+lEPUS9PKxCYhEulFZwRxd
         06bqrTdWnqjtnqc2C3v4TI8GRA6eiJXScnwQfLinTWZ/GYZMRuQkN3HbWHc1PSDNRaEY
         Xl4RNP3A6PtVIwmuNLThV2GWpVrvVfgQSzyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=YPmQgXfSBZ3ub3dBZoYVu7065+sjsPBKQZwPSO80i/GbQ4Zq/dLv8mACdgkyGGD1t+
         qgCRmohlyVm2V6REfFXbloFYk5Ylmr4ZixrVB+94oYZ/0pGBvS9PJl59PckLGunkBj3x
         basucfcdg3HfZnkUk4nGrGtcwjJNQc+vZzzZ9DgNTvTR6cZLo7z3S1r0MUN/7GEYAvPo
         ihK//QdQhT3jvqTAvs5Nl/YTPvgZ42y/oE3LusJl3+j+iw+qv2RwOP1BHfHv4LDP7li5
         LJKD/qATP9HIV0sVU1JI+I6siAOM16ZZBMcuqQEUXCwOlDt4lKYgcv+MbskeJqyQqDs9
         N6FQ==
X-Gm-Message-State: ACgBeo2s/TXd1wDSQn6pTXmVBWEupjsa5YP/sdyJNspGmRmlC3SC/o9j
        OjYl2C+jFWQpOoGFZPpo4Gdn6g==
X-Google-Smtp-Source: AA6agR5RK5bWwK14DmSWfIsVl2lWE7zgftE7SAP1zrNok3zDiq4QmjJez0ZgiEkrRJEXvaPKAwRg5Q==
X-Received: by 2002:a17:90a:8911:b0:1fa:c8f7:1450 with SMTP id u17-20020a17090a891100b001fac8f71450mr10531200pjn.123.1660947491479;
        Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm3603350pjh.50.2022.08.19.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:18:10 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:18:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, davidgow@google.com,
        corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
Message-ID: <202208191518.980071F7@keescook>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819053234.241501-8-tales.aparecida@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:32:33AM -0300, Tales Aparecida wrote:
> Replace URL with an updated path to the full Documentation page
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
