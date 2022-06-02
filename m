Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFE53BAA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiFBOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiFBOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:25:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1267B7CD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:25:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h188so6738819oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XY4Ex8tPNSZJtfNWP8w9y7RN15sCbOEiAJmWuQuEHOI=;
        b=ESskSfAcQdzR8x8+xWNoii8k4hBBU28GAsMLaQ7dDxitmVaVuZyx28sZeOxcT1O1cA
         inVTNTA0GYmbqR4FAEZNX9k9ceVEnH2KuLYqdccBzf5LGkw5XeHKotzyo3fW8gP+7Vsz
         NmJPTjhjkzjOEFtm8ApYIppujhvFoJ/ZPMNbUpZ08xmQ+ncdH+Ie51qNa48kexQ99vmn
         2r4HK6YMep/YzZUsDnzjO8q92Q67URxkT83SNZVFZfvrEr0NhX+JmUKqYQzRZZD5jGPl
         bFXbTZ/q0GPbuwvjVAMlzk/eOl0haO7BUJf/bj3vAWB1/c/a77eCe2oSz2PKQudbCln3
         cDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XY4Ex8tPNSZJtfNWP8w9y7RN15sCbOEiAJmWuQuEHOI=;
        b=rx3aRX12aaIh2FNY5OHQSx88r39TbMJ5ZfGQsieNwSJuxpFILcW1ANnIzklUiIMKyb
         /DtlaHZUyOs8X7FKhJ+glNzB0hy725wyrAvbYO7rsawoWpiUwJOFHAqp/ePHMMlMP4l5
         DXGzjU4Jf/uZTG1j2cCvrjPTIivFw3x2qj8nzuffllzwJYFlCTEB/LOOkKHGWAAz5XWh
         faQHJBoYqhqBNHEd/bUTo/QSQDUCq+NqB6KOjz/jOO6/ki8zfalIjoXRJxfZswNrrgfE
         ZhBMEXuISa6shYhhhcMuTm02Nrbuk8uC4t/exo+43jncACkv+m5kR/JqsvIeLM30zfA2
         /uwA==
X-Gm-Message-State: AOAM531Q5fwsOlu190KDC4YWjZdflux6uTDe0OTmwyOrkDwjwvdEqbrU
        IjO89iEYGMWJg6Madr5qyCUktVPxtOX1N7dWi2c=
X-Google-Smtp-Source: ABdhPJy6qp7ipfBqm83jbBCNmetqux7FBYGMzFOvbQArmVHPU6fwOQfBNyCShnMgPWh1DzfM+QrjU1xDg97j/VKTa8Q=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr17523141oiu.200.1654179909035; Thu, 02
 Jun 2022 07:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com> <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com> <20220602115046.GH2168@kadam>
In-Reply-To: <20220602115046.GH2168@kadam>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Jun 2022 10:24:58 -0400
Message-ID: <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask'
 2 <= 3
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 7:51 AM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sj=C3=B6strand wrote:
> > Dan: I also ran Smatch which resulted in the following discussion:
> >
> > https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html
>
> Since the bounds check is dead code which does not make sense and is not
> required, another idea would be to just delete it.

It wouldn't be dead code if AMDGPU_MAX_VCN_INSTANCES ever increased.

Alex

>
> regards,
> dan carpenter
>
