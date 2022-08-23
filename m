Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530D59D035
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiHWErV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbiHWEp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:45:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF21543C5;
        Mon, 22 Aug 2022 21:45:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so11798243plb.2;
        Mon, 22 Aug 2022 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QuUUyfryCkVJUorV/A+VZepi1QEMQiXOW99WcMLuHuw=;
        b=eht+9FyZkpJrM+iwi94qOYJw8P3DfPPCoLj1tuiL7y5OLtgX1Xs6NGkgQ/WbzpocO6
         3UU35ngOh92eTaPvawOf3b2BqKlELsTys02sS92Sha0CQ4KRxyKDCWyrZWl89cBjGf6A
         GxSH9BPrRpUR5sKq+h4+wn5N2bx0YE5i0AwegzYbVjrbYDXE/dsxbShXtAQUz+8Ei84m
         KxNO/TgJul3pXVjqxSlHyDgyYyh/u5o+2ofh+H2pHb9hC/Ra6QKehDEqnp3zPehV8R4S
         ffi8MIF11pc8ew4QF5aBGmbCjLRb6r/ZnCMcvG7sMzU+5WJkSop7Nd0mKM/xnvsSzwwY
         VdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QuUUyfryCkVJUorV/A+VZepi1QEMQiXOW99WcMLuHuw=;
        b=aKN4xTxjGe8PveCtfhE/FkRPaqaFRFz7qDJeiRk13HpRTNX2ZzQuIMj0vYyag2KH8Y
         Nzz/RLOgjA2np4eJBgyCCIvq6/SU6sh+mkaovM/nZeZYajb6S+k2bksNylEnpJgxuHqx
         pORIZJFUE1Zq21gxk87RmYFoWvVH9CpoCQdkINIz+OvvWSAE3CnAUZif3pgv0iXQyNXt
         kveVfyW9cLTuwibjSej2xh8rycVJLCs7Kg9Be3HLbxJXhpx9SAG8O1ZDuwuUCkxiPiCE
         bCHxSKUrgQUgJ2uWGbKNMGaPez8H941EgjUtDQiOUw15JYCY9y+N/kHmHHg2JCdF9abV
         TO7g==
X-Gm-Message-State: ACgBeo0TYIpEXnyGCIlIUKAsTWMZpiOAcgAarprJBpEb3LdF13J+RSUj
        yFPa9XBwXrQDiw7v09ZmaQ0=
X-Google-Smtp-Source: AA6agR6qk28akKLocpxxgEJ5R9v9M4Vri56QepENWV6Fdk/8QjjamAtfiIVW2jlVKjOubNMdrTeDcA==
X-Received: by 2002:a17:902:e552:b0:16d:2a83:e751 with SMTP id n18-20020a170902e55200b0016d2a83e751mr21966420plf.39.1661229927399;
        Mon, 22 Aug 2022 21:45:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ebe5:ba37:26e1:8072])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090b070a00b001fb05ec17c1sm5042531pjz.39.2022.08.22.21.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 21:45:26 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:45:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/input to INPUT
 DRIVERS
Message-ID: <YwRbZD0/b5xA4hY7@google.com>
References: <20220613115654.28117-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613115654.28117-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:56:54PM +0200, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/input
> are also the maintainers of the corresponding directory
> include/dt-bindings/input.
> 
> Add the file entry for include/dt-bindings/input to the appropriate
> section in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thank you.

-- 
Dmitry
