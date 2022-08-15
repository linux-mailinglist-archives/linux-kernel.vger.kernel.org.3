Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6B59328A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiHOPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHOPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:54:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DAF17077
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:54:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso14801805pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rsucpEsc5D3CWajO1pTl308RBgWxNbG9t1oS7UmiC60=;
        b=c9IES/GUi/YRTnq8ntFq9iy84T/2qbs+aIfYv0AyQOVaTtypUcAHdLJICt2zAB4X/B
         4dYwLy7OnU1nSzGDcBqno4X26p9T2Rg3umFQoxDVNUxYdxj86i442PX0qvGtXBZBJT5O
         3sQ5JTHhnGZBS32J/RkD8vUQ6rKmI+qWTjOgzPlT90vKfz4HJTgGYUiLH6LhUxHnPRWg
         M503lWMUUWF75jkVCwy+h4wAHiI/g8EqkepRunM5afsGvgMLb76BvDnja1k0sJtz48N1
         KfPpIcLxyCXHahCV+A1E+VmS4mGWbTJ5B6r4dj8WQC7yHITiP6iEfPkTD4I+ua+M2mn4
         ob2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rsucpEsc5D3CWajO1pTl308RBgWxNbG9t1oS7UmiC60=;
        b=EdraPRyQeFCan2wO2loIlFbitEvrg1XsqR94gFo7xR0mCYw05PMASWA2g6QIIgYJlY
         396Wx2ukRB33xBdIVlEVlyM/+npDpH+63M8J0ydi8TTbEX1UhFSmnKir8FsC5SNpVXwZ
         42csZKNOqpZSeQSzTyb6/gV0M37UA4/4lLLdSAfoyMQMlgVITUWdI7MZ+MMni7pcFMNN
         /pvDpQKE2iH06f1mNAPQikoanZTGQDmW9vw8XxnQtRV1p0/+lD/9EznBtc/LejAas7nR
         YH+DLsjX1kijtxw7xJb+14FWeb25XLnPwWVcochFGYisfr6KW4/Tx1VljYkErgb2Qrdw
         hcxw==
X-Gm-Message-State: ACgBeo10xvJf746KRBqz0AaXTYw/v/n/kh9Q2ztW4HihAHcp19+NnrRK
        16kAv2LZ7NaubeuYstfpQpY=
X-Google-Smtp-Source: AA6agR7rXwMmQoFFhV9guzX50xC2Hx5lxc/ntTUb9/whlW1Pw7vwVN3TsUywF9bJ3hq6crg1K1/dIA==
X-Received: by 2002:a17:90a:c38f:b0:1f3:2f26:e7c4 with SMTP id h15-20020a17090ac38f00b001f32f26e7c4mr28048030pjt.124.1660578845751;
        Mon, 15 Aug 2022 08:54:05 -0700 (PDT)
Received: from [192.168.141.45] ([103.230.106.6])
        by smtp.gmail.com with ESMTPSA id p67-20020a62d046000000b0052ddaffbcc1sm6719244pfg.30.2022.08.15.08.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 08:54:05 -0700 (PDT)
Message-ID: <f8734af1-6e31-75c9-9556-9519709284f1@gmail.com>
Date:   Mon, 15 Aug 2022 21:53:54 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] drm/amdgpu/vcn: Remove unused assignment in
 vcn_v4_0_stop
Content-Language: en-US
To:     "Dong, Ruijing" <Ruijing.Dong@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Zhu, James" <James.Zhu@amd.com>,
        "Jiang, Sonny" <Sonny.Jiang@amd.com>,
        Wan Jiabing <wanjiabing@vivo.com>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20220815070056.10816-1-khalid.masum.92@gmail.com>
 <SJ1PR12MB61944B1D53330D5E9531158695689@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <86088c17-585c-4a53-312d-ef339b824538@gmail.com>
 <SJ1PR12MB6194C83D51101ACD97B55F0295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <SJ1PR12MB6194C83D51101ACD97B55F0295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 21:17, Dong, Ruijing wrote:
> [AMD Official Use Only - General]
> 
> If the condition was met and it came to execute vcn_4_0_stop_dpg_mode, then it would never have a chance to go for /*wait for vcn idle*/, isn't it?

Hypothetically, some other thread might set adev->pg_flags NULL and in 
that case it will get the chance to go for /* wait for vcn idle */.


> I still didn't see obvious purpose of this change.
> 
>                  if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>       ==>              r = vcn_v4_0_stop_dpg_mode(adev, i);

Regardless of that, this assignment to r is unnecessary. Because this 
value of r is never used. This patch simply removes this unnecessary
assignment.

>                           continue;
>                   }
> 
>                   /* wait for vcn idle */
>                   r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> 
> Thanks
> Ruijing
> 

Thanks,
   -- Khalid Masum
