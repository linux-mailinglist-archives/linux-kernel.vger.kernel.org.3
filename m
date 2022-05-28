Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FE536DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiE1Qw0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 May 2022 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiE1QwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:52:25 -0400
Received: from relay5.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559B15FCA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:52:22 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 6DCAD2F1A9;
        Sat, 28 May 2022 16:52:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id CD3EC60011;
        Sat, 28 May 2022 16:52:14 +0000 (UTC)
Message-ID: <d470331985c7d82c6e5bb6d548ab610479416761.camel@perches.com>
Subject: Re: [PATCH v3 4/4] drm/msm/adreno: Fix up formatting
From:   Joe Perches <joe@perches.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 28 May 2022 09:52:14 -0700
In-Reply-To: <20220528160353.157870-4-konrad.dybcio@somainline.org>
References: <20220528160353.157870-1-konrad.dybcio@somainline.org>
         <20220528160353.157870-4-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: CD3EC60011
X-Stat-Signature: hguqrzykifma4fuxzhcnc6wiq5pkkp7b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19HTwQEza4v02RuQBSx/8pguy5mblJPov4=
X-HE-Tag: 1653756734-471035
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-28 at 18:03 +0200, Konrad Dybcio wrote:
> Leading spaces are not something checkpatch likes, and it says so when
> they are present. Use tabs consistently to indent function body and
> unwrap a 83-char-long line, as 100 is cool nowadays.

unassociated trivia:

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
[]
> @@ -199,7 +199,7 @@ static inline int adreno_is_a420(struct adreno_gpu *gpu)
>  
>  static inline int adreno_is_a430(struct adreno_gpu *gpu)
>  {
> -       return gpu->revn == 430;
> +	return gpu->revn == 430;
>  }

looks like these could/should return bool

>  static inline int adreno_is_a506(struct adreno_gpu *gpu)
> @@ -239,7 +239,7 @@ static inline int adreno_is_a540(struct adreno_gpu *gpu)
>  
>  static inline int adreno_is_a618(struct adreno_gpu *gpu)
>  {
> -       return gpu->revn == 618;
> +	return gpu->revn == 618;
>  }

etc...
