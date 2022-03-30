Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFB4EB91E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiC3D5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbiC3D5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:57:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB6887AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:56:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b16so23463703ioz.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtGZLozjyAIOzsZSlD+JTTWigDKqQpgzm5oFEzYQXdA=;
        b=GEKs8cX9+dTQ0wcyzXEKtdo7wsRCb/3kqRbEhVEUQhxDPvSdXhX9imKsdTQGyhq1FA
         8szamnNrvmxjU60sHdwpsyOHDOApynv4nLLMfHzvSNF5Z7s01LUvf4VlNQz9/tal+wem
         +XUtPO+t/OY4idHz16zFBukaFybQEH5UGcvN+HkmjKWgjC/ThqCRB4hp6/1EnyEuuHYR
         F8/uv5HdduVgTki8ffVbjlg0Ybl1wtiliRI4g2lxqGHWzo8wnXlrSwxJR7nhxtjvtZHo
         O8EnZujZolkKG/la9760q0AoFV5B6fvPlyrYmgGiscgwFZHP2ZzJzMUybskE7zhiuJ8R
         Qdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtGZLozjyAIOzsZSlD+JTTWigDKqQpgzm5oFEzYQXdA=;
        b=G47W8eJRgEgjyKg8ZmBj8n1zORcd4DIfLY0QWSmLeJWnWQ7ZTX+Ua9pQMUNzW/kqob
         5ZHFH9UQrVa+SFCugeAWX5O0aKijGfKygnTmolQEqB4itncKZ9JLYpyT77BGVWyXYh2a
         +zM8aEtC2b8ywGGJ9QTtu3S3B/E4mC2MRCAAVxkq4SrkDKS5WnpdTDt9mjfFWemce8f0
         TMujGg0/rAvtp/s1PVQNfKw2T8jQFOFhacEkkRDqi//yByuWrXYnWPmKOfkZ7cvFEzUw
         yw8MMxtP2jASVFf2ELtSln/7IKGIxIEiHw25gGUsacn39++/gUujU0VVS3gXbvm6SWXy
         4huw==
X-Gm-Message-State: AOAM5334F7SQoYjJ2ELsS2QboXZpi9QYrX05rVMYCALLXxxZa+wXqa8Z
        GXO8+k6tQt4bLMXZC89ca/3FFLSQKz/X+VCjX92Vt+0BJLg=
X-Google-Smtp-Source: ABdhPJwMuy25sNkzJs/eXR4md0OPpU33Yss3XYjnsXRrorIW4S2a4Nc0fT/JGDbUoz1/Z60urvl9Bd+0ikuOaFsgdiQ=
X-Received: by 2002:a05:6638:2192:b0:31a:db8:8d97 with SMTP id
 s18-20020a056638219200b0031a0db88d97mr17440595jaj.201.1648612563557; Tue, 29
 Mar 2022 20:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
From:   ajye huang <ajye.huang@gmail.com>
Date:   Wed, 30 Mar 2022 11:55:52 +0800
Message-ID: <CACCVik86TpCVzVo6jJWNmnduk1a6_z6-Pxe3Vt6kQGRDbOa=VQ@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Add support for max98360a
 speaker amp on SSP2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Brent Lu <brent.lu@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relevant modification on coreboot FW was merged on coreboot
upstream,https://review.coreboot.org/c/coreboot/+/62998.
Based on coreboot modification, the OEM string
"AUDIO-MAX98360_ALC5682I_I2S_AMP_SSP2" is correct by cmd dmidecode -t
11.

Could reviewers kindly review this Linux patch? thanks
