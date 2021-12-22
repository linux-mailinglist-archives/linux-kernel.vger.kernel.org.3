Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6847D36D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbhLVONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:13:16 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:55405 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245605AbhLVONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:13:14 -0500
X-KPN-MessageId: 274244dc-6331-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 274244dc-6331-11ec-8a6e-005056ab378f;
        Wed, 22 Dec 2021 15:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=D7qUlmyWyRiBM87fcOPYLUo3TqeXcR8SLDEfqWVhTeE=;
        b=tQQnRIjzHhP68s+68bMajYZC+ii1qI3/L3IXMw5kKGRQhGTvePFDJL5KOaiwJFupzjV6tU87E0sxw
         inac2+cllLahPQMZVciYEYYUfCQ0BbOBoLQXtkMiC55lnGj0pyOBzcwE60TJ9m4bZ2vlY4GNXf6sLd
         1bsAwShfFsqMMMEltfQsSmbXiuxctI1MLY8+Az6hwEZ+2tn8ZmfibNgtRdhg22CfpLOKiAbOUSGdQx
         AFfBZHg13pBsKdZCnj+C+eKZ+/NDU2jeQPk57vVoBrd/2i5OGSwsUjjeqwMUjPwFfMgKD+DgFPcxPY
         nS/l81eNrXE1uOUCfWDQ5WOMQ+EF1lg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qg0CkmnxFkjnY6FZyiTdaeY6kx8pktK47rEV/taqXLOMDWKl4uNrWffXrYj8eka
 wfPHVTauMYkr6gD6uVRS4Gg==
X-Originating-IP: 80.101.105.217
Received: from [192.168.1.10] (marune.xs4all.nl [80.101.105.217])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 4bcaacaa-6331-11ec-94d2-005056abf0db;
        Wed, 22 Dec 2021 15:13:12 +0100 (CET)
Message-ID: <04e5c9b4-2a96-6b5f-7c26-89e1cbf8576f@xs4all.nl>
Date:   Wed, 22 Dec 2021 15:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 0/2] Remove clock-lanes DT property from CAMSS
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, todor.too@gmail.com,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20211206151811.39271-1-robert.foss@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211206151811.39271-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I posted a PR for Bryan's 'CAMSS: Add SM8250 support' series, but your patch series
clashes with his. Can you rebase this series on top of Bryan's work?

You can use this branch I made for the PR if you want:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v5.17j

Thanks!

	Hans

On 06/12/2021 16:18, Robert Foss wrote:
> Changes since v3:
>  - Split patches heading for Media and ARM64 tress
>    into two seperate series
> 
> Changes since v2:
>  - Stephan: Rebased on v5.16-rc1
>  - Stephan: Fixed 3/4 commit message title
> 
> Changes since v1:
>  - Rob: Instead of documenting and fixing the use of the clock-lanes
>    property, remove it, since it is is not programmable and
>    therefore shouldn't be exposed in the DT.
> 
> Robert Foss (2):
>   media: camss: csiphy: Move to hardcode CSI Clock Lane number
>   media: dt-bindings: media: camss: Remove clock-lane property
> 
>  .../bindings/media/qcom,msm8916-camss.yaml    | 10 ---------
>  .../bindings/media/qcom,msm8996-camss.yaml    | 20 ------------------
>  .../bindings/media/qcom,sdm660-camss.yaml     | 20 ------------------
>  .../bindings/media/qcom,sdm845-camss.yaml     | 17 ---------------
>  .../qcom/camss/camss-csiphy-2ph-1-0.c         | 19 +++++++++++++++--
>  .../qcom/camss/camss-csiphy-3ph-1-0.c         | 17 ++++++++++++++-
>  .../media/platform/qcom/camss/camss-csiphy.c  | 21 +------------------
>  .../media/platform/qcom/camss/camss-csiphy.h  |  7 +++++++
>  8 files changed, 41 insertions(+), 90 deletions(-)
> 

