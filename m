Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0058DC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiHIQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHIQcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:32:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FF192B4;
        Tue,  9 Aug 2022 09:32:44 -0700 (PDT)
Received: from beaker.jlekstrand.net (2603-8080-2102-63d7-019e-342e-5881-a163.res6.spectrum.com [IPv6:2603:8080:2102:63d7:19e:342e:5881:a163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: jekstrand)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 844776601C5B;
        Tue,  9 Aug 2022 17:32:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660062762;
        bh=08B1dX3gAyCyt7HHY55sqZ0SuaeO3yqxbdw03xUaetg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FAar9p+dtTgGgZLkiX5DUXgzJVL6kTFg7OcUeCozn25aHe+bk4Hd3XPbNiqmxK0+m
         c5NOEUd+UXLWAmokYKcQarA9S8mNVZLbkhSEaeZNvv0YrbQo9qEgzd2pp3IEt18CbR
         7W0UQLAWbsz+3sXCXUIKKFIOXpkroOwm3P2k1qyJmB2G54AgABgDGGYYi2L4WSakhS
         YylWonFFn6x2KbVHMsWpifs0eDpp5sTWPcG//EvuDGIyOamwmDv/tmkmbBWF/dsAjg
         JkeY64mCyb2y/A0caTgZplHQXCaRo1v5dQHP9EuFzJAnCzk1Gtczr5dVF1b52JUh1f
         62P6Nvoryuwag==
Message-ID: <731935a814e0decf2ff5c7771cd0bba9a72fa654.camel@collabora.com>
Subject: Re: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned
 R16_UINT/RG1616_UINT formats
From:   Jason Ekstrand <jason.ekstrand@collabora.com>
To:     Dennis Tsiang <dennis.tsiang@arm.com>,
        Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Normunds Rieksts <Normunds.Rieksts@arm.com>, airlied@linux.ie,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        david.harvey-macaulay@arm.com, Lisa Wu <lisa.wu@arm.com>,
        tzimmermann@suse.de, nd <nd@arm.com>, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Date:   Tue, 09 Aug 2022 11:32:35 -0500
In-Reply-To: <7e8856ac-40a1-6fec-042c-c2a01775beeb@arm.com>
References: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
         <20220627175026.6a5dd239@eldfell>
         <05513f59-0bd9-77cd-36d4-41027bc339be@arm.com>
         <o1qcCo8e19pmmNe-YJbPkmu4SBrOQ_E3u7eqdrcXUzdBccLtFswL_ARTpbrX9C10tippuy5ieXAsqdf7H47JuT7Hqa1NlizAPqVuRM0kRt4=@emersion.fr>
         <20220630104725.602bff9a@eldfell>
         <7e8856ac-40a1-6fec-042c-c2a01775beeb@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 11:20 +0100, Dennis Tsiang wrote:
> On 30/06/2022 08:47, Pekka Paalanen wrote:
> > On Wed, 29 Jun 2022 14:53:49 +0000
> > Simon Ser <contact@emersion.fr> wrote:
> >=20
> > > On Wednesday, June 29th, 2022 at 16:46, Dennis Tsiang
> > > <dennis.tsiang@arm.com> wrote:
> > >=20
> > > > Thanks for your comments. This is not intended to be used for
> > > > KMS, where
> > > > indeed there would be no difference. This proposal is for other
> > > > Graphics
> > > > APIs such as Vulkan, which requires the application to be
> > > > explicit
> > > > upfront about how they will interpret the data, whether that be
> > > > UNORM,
> > > > UINT .etc. We want to be able to import dma_bufs which create a
> > > > VkImage
> > > > with a "_UINT" VkFormat. However there is currently no explicit
> > > > mapping
> > > > between the DRM fourccs + modifiers combos to "_UINT"
> > > > VkFormats. One
> > > > solution is to encode that into the fourccs, which is what this
> > > > RFC is
> > > > proposing.
> > >=20
> > > As a general comment, I don't think it's reasonable to encode all
> > > of the
> > > VkFormat information inside DRM FourCC. For instance, VkFormat
> > > has SRGB/UNORM
> > > variants which describe whether pixel values are electrical or
> > > optical
> > > (IOW, EOTF-encoded or not). Moreover, other APIs may encode
> > > different
> > > information in their format enums.
> >=20
> > Yeah, do not add any of that information to the DRM pixel format
> > codes.
> >=20
> > There is *so much* other stuff you also need to define than what's
> > already mentioned, and which bits you need for the API at hand
> > depends
> > totally on the API at hand. After the API has defined some parts of
> > the
> > metadata, the API user has to take care of the remaining parts of
> > the
> > metadata in other ways, like dynamic range or color space.
> >=20
> > Besides, when you deal with dmabuf, you already need to pass a lot
> > of
> > metadata explicitly, like the pixel format, width, height, stride,
> > modifier, etc. so it's better to add more of those (like we will be
> > doing in Wayland, and not specific to dmabuf even) than to try make
> > pixel formats a huge mess through combinatorial explosion and
> > sometimes
> > partial and sometimes conflicting image metadata.
> >=20
> > You might be able to get a glimpse of what all metadata there could
> > be
> > by reading
> > https://gitlab.freedesktop.org/pq/color-and-hdr/-/blob/main/doc/pixels_=
color.md
> > .
> >=20
> > Compare Vulkan formats to e.g.
> > https://docs.microsoft.com/en-us/windows/win32/api/dxgicommon/ne-dxgico=
mmon-dxgi_color_space_type
> > and you'll see that while DXGI color space enumeration is mostly
> > about
> > other stuff, it also has overlap with Vulkan formats I think, at
> > least
> > the SRGB vs. not part.
> >=20
> > Btw. practically all buffers you see used, especially if they are 8
> > bpc, they are almost guaranteed to be "SRGB" non-linearly encoded,
> > but
> > do you ever see that fact being explicitly communicated?
> >=20
> > Then there is the question that if you have an SRGB-encoded buffer,
> > do
> > you want to read out SRGB-encoded or linear values? That depends on
> > what you are doing with the buffer, so if you always mapped dmabuf
> > to
> > Vulkan SRGB formats (or always to non-SRGB formats), then you need
> > some
> > other way in Vulkan for the app to say whether to sample encoded or
> > linear (electrical or optical) values. And whether texture
> > filtering is
> > done in encoded or linear space, because that makes a difference
> > too.
> >=20
> > IOW, there are cases where the format mapping depends on the user
> > of the
> > buffer and not only on the contents of the buffer.
> >=20
> > Therefore you simply cannot create a static mapping table between
> > two
> > format definition systems when the two systems are fundamentally
> > different, like Vulkan and DRM fourcc.
> >=20
> >=20
> > Thanks,
> > pq
>=20
> Thanks all for your comments. We'll look into an alternative approach
> to
> achieve what we need.

I mostly agree with Pekka here.  The fourcc formats as they currently
are defined only specify a bit pattern and channel order, not an
interpretation.  Vulkan formats, on the other hand, have everything you
need in order to know how to convert float vec4s to/from that format in
a shader.  That's not the same as knowing what the data represents
(colorspace, wite values, etc.) but it's a lot more than fourcc.

That said, the Vulkan APIs for querying modifier support will give you
much more fine-grained information about exactly the Vulkan formats you
request.  So if you ask for modifier support for VK_FORMAT_R16G16_UINT,
that's what you'll get.  I *think* it should be fine to use
VK_FORMAT_R16G16_UINT with DRM_FOURCC_GR1616.  Of course, the API on
the other side will also need a more precise format specifier than
fourcc if it's to know the difference between R16G16_UINT and
R16G16_UNORM.

--Jason

