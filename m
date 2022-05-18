Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12DF52B992
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiERL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbiERL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD14F45;
        Wed, 18 May 2022 04:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E909EB81F93;
        Wed, 18 May 2022 11:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71455C385AA;
        Wed, 18 May 2022 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652875014;
        bh=9vOoc0v+BIYkpytw8iBPivZ+HzNBFguqZOXNLAw6pLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Irbz9HalufQgGqTpCt8jY8Xm1siWggiektz9izx5891iEwNqN+DXa2Lu7Hwz/yMgM
         7AjzcF1Wv0whPCL1zeMQkL8a/R21522q487O5jeyHJAlPKveanVPxAbeBfCI7vL+qP
         EgPyXb6pgvfARMWftzyE/11KCHVPcUjXofl0GqZzbAmtTbDgwcM36nRkYTEHgF04wC
         O+vLlTlKQEEhW8QD8Q+EjqR20fM3NzFISDbB7K376Juo+VNDh6pl4dtFVqHqYMXECp
         UTouosNDQQ1BlRF5gsdStQtZx4TBAn6Hrgogn6ILgm3J4v8moGLtqaEN7JOAh/17+e
         i0TLaJ5G63Hpg==
Date:   Wed, 18 May 2022 19:56:50 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Documentation update for Chrome OS ACPI
Message-ID: <YoTfArGLd85jaG2Y@google.com>
References: <20220518083524.37380-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518083524.37380-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:35:22PM +0700, Bagas Sanjaya wrote:
> Two documentation patches touching Chrome OS ACPI sysfs.
> 
>   1. Patch [1/2] fixes htmldocs warning reported in linux-next and should
>      be merged before upcoming merge window.
>   2. Patch [2/2] rewrites symbol descriptions to use imperative mood. It
>      can be merged when appropriate, independent of previous patch
>      above.
> 
> [...]

Applied, thanks!

[1/2] platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs ABI
      commit: 596cbc6ab0abd18206b3247aaeaa225788afaf8c
[2/2] platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI descriptions
      commit: 7bff62406671dd89e9d1a7bf00169197f2833c41
