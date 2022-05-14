Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092375272CF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiENQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiENQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE5F0C;
        Sat, 14 May 2022 09:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD35260C1E;
        Sat, 14 May 2022 16:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DAAC340EE;
        Sat, 14 May 2022 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652544545;
        bh=vfe0fN5WaDr3IfTMVdsfaQTO0TXDCSNrCIB2jRLk/Yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AZlhOL64713KaCmyJUdhXzrQfv1pdQSFUirmAPGhxrvO9OaFYvZOxtzWJLi/FcUk4
         FrS5CZpbGfb6woDsY+P1C+oh6dDykOhzuZ+SQ0bgBOg3ZzLYKxHEgYjFgL85av+Mz2
         pZE/k1wsk3EfCox3QzBk9OysL9NpftVIB1MLJkJ2y0sMDgSapuGSu5nRFbnRU3X7i0
         750oQ1N2sOpUkMhIZZCQcxWw1TQOih19m7Q06dRbHNZQ+a6vYVdMbSfAGVspCUtymO
         jO0+HbPCskdAdJneyPPPRmkuYUoMGbF13Sm6fTK37Habf3StrLMPuID+3/Rp2SfD6D
         2RidhLpWxytKg==
Date:   Sat, 14 May 2022 17:17:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, Zhigang.Shi@liteon.com, krisman@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220514171738.062b127d@jic23-huawei>
In-Reply-To: <57bfc915-c761-3ba4-93d0-776f9b5f93b3@gmail.com>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
        <20220511094024.175994-4-shreeya.patel@collabora.com>
        <57bfc915-c761-3ba4-93d0-776f9b5f93b3@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 02:40:41 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> Hello Shreeya,
> 
> ...
> > +#include <linux/init.h>
> > +#include <linux/mod_devicetable.h>  
> 
> You may safely remove these includes because module.h always provides them.

Safely yes, but generally I'd prefer direct include
of mod_devicetable.h because of the direct use of
elements from it in the driver.

Jonathan


