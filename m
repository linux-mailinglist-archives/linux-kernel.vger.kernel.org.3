Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1AB4E5C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbiCXAzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346931AbiCXAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BF9FDB;
        Wed, 23 Mar 2022 17:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC814618C7;
        Thu, 24 Mar 2022 00:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4455C340E8;
        Thu, 24 Mar 2022 00:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083250;
        bh=YY3u466kTq8l7wermBlxhgdP++tiwPwanwuGyPYg6s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxnCxduQPUEtFRtz4pfTOwPtQANiGZ65a2nzfWJGOR2BuGXbi4CH/nLRc4IVFyJdZ
         pHQtkvn9oUDLzSlxdwpOLzpmQRcX5E0GB9D7TgD3q5u4Gm7Ekv1pHgAMEdjNpI+Cob
         ybgoGdRXXL9xonOMGn9DdzGykpync49zxln9j1HN5A25pmep2rmcjPzShaJvYQxnMj
         YCJz+7HbpdtBNtiJRyK63VGSWbllaC7WFF0JeXudbdfzmuMyrSWTLoxMES3vCZw07b
         vfWIdHGuwxKEgGJBnuF/aQjS4QNloXm37m5cEdJLs40XnY3W99A9Gwjm4PlgSYrWi5
         8/KhjEKM0+N+Q==
Date:   Thu, 24 Mar 2022 08:54:05 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v6 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
Message-ID: <YjvBLf/8M1WUS/L+@google.com>
References: <20220323164442.921-1-jiaxin.yu@mediatek.com>
 <20220323164442.921-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323164442.921-2-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:44:39AM +0800, Jiaxin Yu wrote:
> +  speaker-codec:

If it is possible to have 1 or more items, would "speaker-codecs" be a better
name?

> +    type: object
> +    properties:
> +      sound-dai:
> +        minItems: 2

It should be 1.  Consider of rt1015p case.
