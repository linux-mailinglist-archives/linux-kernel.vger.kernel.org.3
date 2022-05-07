Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2542051E871
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386091AbiEGQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiEGQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:14:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31876342;
        Sat,  7 May 2022 09:11:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A81F55A;
        Sat,  7 May 2022 18:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651939867;
        bh=se6o+9yWQACYAlaRsFAG9CGqkeJ/BhQO9jJBskb2Neg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqNOBIfbd+f+sPsUEmlUPkIqCxXSgnM+73ZAftzPl3DpAkHNQuo02O0RoWY32BwuP
         hT0N7IwYKV5SXM/OFr60fGDCoeq++bZRBBby5U4v43ddEJOmSvT65Rzc01MALAcbbr
         AAGZQ0kTMJNvx9m6Vp+VkO2m5VmDiOeA4MR+hg84=
Date:   Sat, 7 May 2022 19:11:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sergey Meirovich <rathamahata@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH RFT/RFC v2 01/47] staging: media: Revert "media: zoran:
 remove deprecated driver"
Message-ID: <YnaaF8AtSA8glnEg@pendragon.ideasonboard.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
 <1601058657-14042-2-git-send-email-clabbe@baylibre.com>
 <CA+QCeVRjnU6RwHkj3c54pzLq6yeaZ1Lz8eG4vDOkGT5RyKvJhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+QCeVRjnU6RwHkj3c54pzLq6yeaZ1Lz8eG4vDOkGT5RyKvJhA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 10:58:39AM -0500, Sergey Meirovich wrote:
> Sergey Meirovich has sent you an email via Gmail confidential mode:
> 
> Gmail logoRe: [PATCH RFT/RFC v2 01/47] staging: media: Revert "media: zoran:
> remove deprecated driver"
> 
> This message was sent on May 7, 2022 at 8:58:50 AM PDT
> You can open it by clicking the link below. This link will only work for
> laurent.pinchart@ideasonboard.com.

Please don't use this feature when posting to public mailing lists. Such
messages will be totally ignored.

> View the email
> 
> Gmail confidential mode gives you more control over the messages you send. The
> sender may have chosen to set an expiration time, disable printing or
> forwarding, or track access to this message. Learn more
> 
> Gmail: Email by Google
> Use is subject to the Google Privacy Policy                            Google
> Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA    logo
> You have received this message because someone sent you an email via
> Gmail confidential mode.
> 

-- 
Regards,

Laurent Pinchart
