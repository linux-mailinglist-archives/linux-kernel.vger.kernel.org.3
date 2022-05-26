Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDB534E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiEZLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiEZLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:41:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B51DA5C;
        Thu, 26 May 2022 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653565205;
        bh=GbdIaIIk78hNi8gQCmD4dMLd0D25sZO/rqp6h4oacX4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U2Fdg8gF9KgPifWJIy5i0JSAgT9bvp/S/TpbBh9XbRd2CGmyMVDE0vukEEUqMItKL
         KjbjzLvr2lzUm6BmVq+MaQLX9v8fl1wj1CIT3L/vBot6dhEhVWcbthgvSL5Avo/Ih4
         6X0FiOIdK345gdD+61naUlsacTnRl0V7G3K5jqXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.164.234]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1oBRcD3NnV-00HuNE; Thu, 26
 May 2022 13:40:04 +0200
Message-ID: <26772d5c-5630-799b-5f10-33e3f7ba083a@gmx.de>
Date:   Thu, 26 May 2022 13:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] radeon: Fix spelling typo in comment
Content-Language: en-US
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220526062757.1155581-1-pengfuyuan@kylinos.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220526062757.1155581-1-pengfuyuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i6AuLEP6gw6wM4fkV8X6gXcJuhH5Qswx2kDD6/VD/KhvN0D8XWF
 DfNxTdzkI8sCW4uYlvtzgHllO1xo0mYne5aiefuObrIx3wzbFXzjaopArIR1qo5mCueEbmR
 Ai159xgDLdZQII7qBwvhyCZifyCM/O8xe6sE1tdQkI13UCgOVJScsFA0k77/A9+qAJxFGZI
 13yl5esPQr65Dd9xF2SOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gDlbvIfId4=:3xabrUmqyZGfdU3/Pcgbs/
 AIzx+Fo5oBKKivd0VAGF7Z9rAUUUbkLBhR3vuRiZX70oojyuECT+qH52LNGcNlqpxP5t335e8
 87nMZIB8wHjGfymCbNoLy6vxmH8W1n/uI5u2RaxNR/bS5U2gVaqAqigqOwc5oictDpCP6dXGz
 R+c6EArR6rmbr9fe69G8rfxNP5H6ckbTF18IHLts4CMBrukWaAhro5OSVn0q7HkakXZR7bYbH
 JqgnB6HHZaxdpQmhGn3Tw1DUElLobEMpIP2yy3J2XFm5ILYrD3cCL6rBm4m10cbQaFoF10U8p
 KGCKhf4cCtMCSkl9wQuOZmKSpYrCDAMnzo5FzL0fcnRvcS3OMgAlM473BcO5AMNkmu1oM4Phv
 aD7AQ3ia5nGm4+SQflTHGR3m+Rd3YdgX/JQy606vs0ote32Ku/0CwogEJS13F8qnNLiKGIsw+
 S7Nx6ivMp5fUNdvPowirZUaN+itSCoVSst5CGpY85+SYvNJjJLhy/OsrcUgnGTmAkW8fd5F04
 kRs75z786tTNbZI2eLNXHhykhSp3tJcqUtQaAkIlELGlZNuNXHGrrKiXWRQt1wTvFRlTIr833
 lcjsyon2bBDNmRh3c4SOhcoLbDzT/zF1TQtj6VkZREmgCkdffqbhl/i0eoPShSl3+ZEKnJ1yV
 XTUhd4ezEPyi9+KnhOAK/zaou4x8I/96Kr1NecnYqiH3kRaCHa2EJMxIOrqCmOP235ArxEPiX
 sxAtGK6s5qE9hI8mxIKBwlocBh3+Axlb+XdZRrOfdKKOZx8YTxYFpXCxCJJvQwqsTdUO12LIF
 XyFwqM1/WJgPRDh6xrLAvU8mQ0uJQiaxz1RURsrkVQAZx4yor72bDxHPMx8QyGVIhAMvDEFR+
 3xkrsMUybgD+nDpuAeFqxrkaZWzqpICAAMB/9k34z/Isbv43FPleIgTIs/G4hnhQEIX+9Uhd2
 DpAG8bEiFN9SE90d6nI2cER/N9z+jR8Qco2TWOecYE4Rf9nh6tt3Nj72UzvM1SF79a7P7Oznh
 3eZ5g2i9qKA9oUDQfOyBRlW1ZxsWyEDj3vrFMh+1T9dWZ4dgX/dXbFqZtZa8HV4NCaFL9DQVw
 ugu5NcmDjyF1sQoxUdcucO4i4Rs+CXr6NZGLFqKvM8Wnv5Sd3BYgxVvXQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 08:27, pengfuyuan wrote:
> Fix spelling typo in comment.
>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>

applied to the fbdev git tree.

Thanks!
Helge

> ---
>  include/video/radeon.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/video/radeon.h b/include/video/radeon.h
> index 005eae19ec09..72f94ccfa725 100644
> --- a/include/video/radeon.h
> +++ b/include/video/radeon.h
> @@ -750,7 +750,7 @@
>  #define WAIT_DMA_GUI_IDLE			   (1 << 9)
>  #define WAIT_2D_IDLECLEAN			   (1 << 16)
>
> -/* SURFACE_CNTL bit consants */
> +/* SURFACE_CNTL bit constants */
>  #define SURF_TRANSLATION_DIS			   (1 << 8)
>  #define NONSURF_AP0_SWP_16BPP			   (1 << 20)
>  #define NONSURF_AP0_SWP_32BPP			   (1 << 21)

