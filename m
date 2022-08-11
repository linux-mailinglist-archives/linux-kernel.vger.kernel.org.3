Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822E75908F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiHKXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiHKXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:12:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607490C52;
        Thu, 11 Aug 2022 16:12:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 17so8828714pli.0;
        Thu, 11 Aug 2022 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Uy/hk7mGj/R8FD0mj+fG9afG1PTPd5xuoXu3SDIYhR8=;
        b=oBTsbb69/AKxYZl3cXKQc/xa1T7SFGPBgYekfZcdf1bVH1f2xdTnXX4mGMeOxN9nPf
         rD0vzyxcSento3mNj8djpq/JkGWgr66UZaE7slDP7vLg11Zj4IaHdvXECOmo/NqZmf8M
         bhf8WqakZd4mzQ6Sdw8C4ktNW07Uce7shSbJcgH0FPTtZyWHT+V5kkAZFYvOlaAZeDoH
         OG6e5lCUf6KbLvG45hiYlbsLdLXkMVyNDgibbmWHoteMsvS1BKwzpuQTHy6fS8tAuTXp
         ddTPstDykfBjYXj5fgMqxaLOTX1YVFjxkDDrOND1GMHLXFWTxYmN6yRs4DAV5h6f/6nP
         Mq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Uy/hk7mGj/R8FD0mj+fG9afG1PTPd5xuoXu3SDIYhR8=;
        b=KTTC7UHWLzFxSbcgov2F3a4ieMn+QuAJ5VjNCgGQNharBJoQtZV91iqRG71bigX4p8
         A2Kl1Px61lpy5IZFn3LD6zX7kyhCzhcGyXVHxKyjgc5Rr+yowzCOKusXN8IgvUNvh71v
         raNe+wA11VHLsPt+LV+7EjrBJwN77NZWxo/khazl/qLSVi6/xnMeO41BMC7fqNtOkssZ
         wcwA21hqxzr62uzqAQrVf9tuVyAck67TULf8sCC+gkiWOKYOFz69OYhkfyzKW0FMxhs1
         Juxex4YeNS43iaKcKUjkf1CdMH5FzJydipVM3l54F+ZYmKmOpGT6kVy7/TxEJUhZAbeY
         cKIQ==
X-Gm-Message-State: ACgBeo1oVBmNL0Y/khlhSnXoofBp7D9iobhlYvKZTOEd+3WwOHdXKCTH
        oOp38/ottJukWAD+N7CGVvE=
X-Google-Smtp-Source: AA6agR5SVhQHqXQWIAlU6WTAIHSdgSZe9VoPEVjSaCQKMFxAmw0YNTuHK04Gf5jQCLX+KFuT8gtqJg==
X-Received: by 2002:a17:903:22c7:b0:171:516d:d2a4 with SMTP id y7-20020a17090322c700b00171516dd2a4mr1324428plg.98.1660259547828;
        Thu, 11 Aug 2022 16:12:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id r38-20020a632066000000b00419acadde52sm258097pgm.46.2022.08.11.16.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:12:26 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:12:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tc3589x-keypad: Use correct struct names in
 comment
Message-ID: <YvWM2Jva7tJz6W7x@google.com>
References: <20220805174717.2374416-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805174717.2374416-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:47:17PM +0100, Colin Ian King wrote:
> The incorrect structure name is being used in the comment for struct
> tc3589x_keypad_platform_data. Correct it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
