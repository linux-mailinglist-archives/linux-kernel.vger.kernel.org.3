Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01644C92C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiCASRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiCASR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:17:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A9396B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:16:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so21901535wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LVn6k5aiaB+GlDaGyWJHbIXnA3GgZuVF6+u4SGe3ogM=;
        b=WaiAgpv3J7rF8Pqe1r7FOjhpegyuZ0do0SeDPmp1nbUeL10bGp0rZEtl9XL1irkTtY
         gGwOV2XFy3L+aVC1lcyX8Uq9H6WQGNNrRbPI+4i6CgrDUUKTgsQ/SG8/6wxtz+62VFe4
         uPvZnxmcPzL+tpM9pZF8Q9oY0bcp46r9mSFV18Oc3p+qCDcngKOS5daijP/3nuJOLd7s
         Z/qwEXpbzfSUMO+7rcfq6l007qVLnERcp37TB3TU0oxnlAUdE7jt4AAOY0csaHMccwv4
         +kI0XDTdzl3Ixssxv4NPsRXLohKZvdyrjhMYFjhPTBplqwGxDSpXS8QN6elU3X2DjK7i
         Q3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LVn6k5aiaB+GlDaGyWJHbIXnA3GgZuVF6+u4SGe3ogM=;
        b=65ToqC2p9KDMyB3LQhY97bkO69utB+3B07OghzeqeObG6otV/w+DsZod0YHOHrOpnu
         IPE24ZOS/l+sSdKdscIZWYZeBNIqfHZ8fE6mDq5SkOJuScns9iaPOoFVqQrpaaopXHtp
         e9OOYEX2sISEoOO3qLQdLedE6Bk3CoD3CMfjsN6nS0zV4OogcWO79Ndhx00lzsw1p1h7
         YALuTPGJheOnq+AWWeQREKn4UbTV8wzcJwiVTKt+hxdVJZPw8sQV9ZwzC2xo6DPCJGVU
         Z7EBOlfJM7bmcg5RVzaFLZNeGDSNBmduQJorWr9zHrFPKFrwzEC/PxAUgXo9uWsTCY6L
         4J8g==
X-Gm-Message-State: AOAM5306BtAD+toyY5k8bguIc1P2f4lsFdVuPN08PH8pVCE8vXSJs571
        qkNsQPb2ENj3XNOgSB3L/VcWYhw0YG8=
X-Google-Smtp-Source: ABdhPJz2O3+OUx/EA5k6y1mcMZVkUS6jqbXfFwpHb77tIU7478wTiF9L68gKP5PT0f+19+3an4UDew==
X-Received: by 2002:a5d:678f:0:b0:1f0:2471:5a93 with SMTP id v15-20020a5d678f000000b001f024715a93mr900614wru.164.1646158606574;
        Tue, 01 Mar 2022 10:16:46 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l13-20020a05600002ad00b001ea78a5df11sm16831088wry.1.2022.03.01.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:16:46 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:16:44 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: boot flooded with unwind: Index not found
Message-ID: <Yh5jDO6xPst7RSfa@Red>
References: <Yh5ASXVoWoMj7/Rr@Red>
 <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 01, 2022 at 03:49:41PM +0000, Russell King (Oracle) a écrit :
> On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > Hello
> > 
> > I booted today linux-next (20220301) and my boot is flooded with:
> > [    0.000000] unwind: Index not found c0f0c440
> > [    0.000000] unwind: Index not found 00000000
> > [    0.000000] unwind: Index not found c0f0c440
> > [    0.000000] unwind: Index not found 00000000
> > 
> > This happen on a sun8i-a83t-bananapi-m3
> 
> Have you enabled vmapped stacks?
> 

Yes, I have CONFIG_VMAP_STACK=y in my .config
