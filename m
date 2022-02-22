Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471BD4C0566
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiBVXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBVXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:38:53 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756364B863
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:38:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y11so13637670pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=z14gdztNmeBCFYN6Nsa2blKh3AYnO4tYG9TJ7do4igA=;
        b=P8gl+rGgObz5JsQXub2YaOttUkPyGb7i1SkmFpqxkIGdUAU4YRxZiisW87LG9VpuCb
         4xpTct734i09Qzvlpxm2rsqYyXUeerHt09s8oTueO0vyy7cZq824/v8CE3tLThpYelvl
         eGhZ7/kKZNE2OzXT2ZnCyxKGFSGiR2+9TGAg+1jte1PnDWyifvCjffRrTEx8WPNVXUQh
         Ss0lTlHq8dKJpg115nPsBQWM6W9sHaYtYCXG5ghn91RI8pHSvR7KpVfQavU1lD7gLMkR
         fHgjaNKyXXnLzLV5azir/FN8AoEUAlUNfS4x+XnLacwJ6pNtrFt334tlZsU2uR+7Lfv4
         pT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=z14gdztNmeBCFYN6Nsa2blKh3AYnO4tYG9TJ7do4igA=;
        b=7u1SscxDom399WG/XFzKDxYD3fsPoy50dLsynBje7j6Trugl+WKT0+aLa3m391UsBc
         hUapik9snq49sXG7fvcKJ7hZBI7Fb9czcoFQbx4y3h/Jlueclc7G4+iwN4leBvqv/81I
         GuRfk7rakPbdOWgbZuMvjhMcYRRQ1ht3pEpm+L/FzMGN7NzpB0x4+T5mQThYFex8ekN8
         Vh3FoxMoATAWnJZnv3pTT0ZY2LO2g2g243cKYuTKspBKxWjEAhAf23AKx2HYOwDOmqgH
         dadg1wJDZlhBU9ugcAlioDNiNIklUac2cNqck8d96MZy8gSa2W0if9ZUbD5OG02acNRA
         f7Kw==
X-Gm-Message-State: AOAM532r5URvWlHndxsM1IBewmSaCnqneDBJsw+BGoXdvlgM88xdZ7JI
        OfJPYyqhcjPzHymAasu1n7OTog==
X-Google-Smtp-Source: ABdhPJxooYUF3cMjgU9bh8ub5zJAQM7l/5INUFoLGNz1daFOw83ZQTajR0NlWO7J06goIxmoJ8O6Qg==
X-Received: by 2002:a05:6a00:984:b0:4e1:5e1b:1e9b with SMTP id u4-20020a056a00098400b004e15e1b1e9bmr26851040pfg.71.1645573106467;
        Tue, 22 Feb 2022 15:38:26 -0800 (PST)
Received: from [2620:15c:29:204:6b0f:423a:fd82:4e05] ([2620:15c:29:204:6b0f:423a:fd82:4e05])
        by smtp.gmail.com with ESMTPSA id c9sm19098644pfv.70.2022.02.22.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:38:26 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:38:25 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS, SLAB: Add Roman as reviewer, git tree
In-Reply-To: <YhU7T//RK6E+1Nig@carbon.DHCP.thefacebook.com>
Message-ID: <2c52e740-8373-4234-aeef-928abb41f521@google.com>
References: <20220222103104.13241-1-vbabka@suse.cz> <YhU7T//RK6E+1Nig@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022, Roman Gushchin wrote:

> On Tue, Feb 22, 2022 at 11:31:04AM +0100, Vlastimil Babka wrote:
> > The slab code has an overlap with kmem accounting, where Roman has done
> > a lot of work recently and it would be useful to make sure he's CC'd on
> > patches that potentially affect it. Thus add him as a reviewer for the
> > SLAB subsystem.
> > 
> > Also while at it, add the link to slab git tree.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Sorry, used the old e-mail. Here is the correct one:
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 

Acked-by: David Rientjes <rientjes@google.com>
