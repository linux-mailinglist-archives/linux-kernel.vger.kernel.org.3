Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A75385EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiE3QLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiE3QLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:11:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C83A5F3;
        Mon, 30 May 2022 09:11:41 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxDgm-1nbiC331j6-00xXYP; Mon, 30 May 2022 18:11:39 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-30c2f288f13so39766167b3.7;
        Mon, 30 May 2022 09:11:39 -0700 (PDT)
X-Gm-Message-State: AOAM531ISlRInc2Xwuxpy8R3BNV/MMpjTlU4b12H4/BovxC+/vUkvhZ7
        y5MJgOK5XqhP2IaLHBj1iwAwesNehFETh9XuFOo=
X-Google-Smtp-Source: ABdhPJzz3XlqawyrllmUlfmpCRvsScEJzlN451+7Mmq+gGGuBjqysfamSt3+XlP2gFPc9sId0jCRiqlAcBI0boxBsTg=
X-Received: by 2002:a81:28b:0:b0:30c:5e57:fac3 with SMTP id
 133-20020a81028b000000b0030c5e57fac3mr4506381ywc.249.1653927098209; Mon, 30
 May 2022 09:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
In-Reply-To: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 18:11:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2b05w3uRjXhx7CgdLEHL78ZHRjgOYoG_SR0SyDxcLDMg@mail.gmail.com>
Message-ID: <CAK8P3a2b05w3uRjXhx7CgdLEHL78ZHRjgOYoG_SR0SyDxcLDMg@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org, agross@kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HjsYA+nrojhCIllRkh3gdovi3Qg5wl0dW0CKHI0r/POmXLGGqhi
 7kgE6qEs+iFxMAZ1F301SkzE4kkctb9K5tqCl3/85/crUk0LI285LW7ZSJTv47601yNsabx
 UVQieCq94RBDD2OK2iLvT24SLE2byxsEFLic0EsUI0RYFztiGLpML851GgDxhPthqfpl1ip
 UgC1fx1MHKEILUOdUTsFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w02Pzz3C5XQ=:vZ/x27lMmOlXjpUFhvk6hg
 /XJmrkyPjDqFk8UZjreOELRjvweTubirPAYkp0amL8wgOOCb0KZpYV9WkvTOHDUgH7BpGKr93
 dqYINIfKoOiVjndt51yQF0mskNhL5gwfnZKDE57UlX8V1advBV/ETkrb7lisxy4K7T2vLR0zx
 s/jvBsP1gA3wI6geloszXKPi9oynrKEMzdtjS3TSWsqKZWBfZq+0/37+sxziDz+832RMLfpz8
 Et06EhTzU+3mk495BKrJVHfkbBadgvCnbD2Tr4Q/0qJKvKdEhJ2zwMA14kMDDcJjQpt21ZRyc
 YuAGvZMsV52Vaj7/QxyTFZD9/VBxwrZTqEZIOaD9erpe3tytl73QCNKdQsSfi8wU/n2C8jz1W
 9DwG9FW6K8ZTB3QH0teKoQBK8cSXY38ftQw/m0fCyicvsm+mFiuvHP9fnnclgcfvq8ERZSjIV
 RYzraigs7bdIF8UxhbAXA5TbkE+LtIXwONMFVnZ8+ZFBmDHp4q/6P4skXwf2Vo4T1UO0Im0Zl
 ttzlLgjq5g1+1oaCUfJEXgVteKbVKmAClFqkN5vJ7oO+WvYyr6jbTsFuFIt2r3t3QSwRwpmlg
 /2E8nDmgKZXhCj5afsDRDsaCPSHJNmsfFzUBkKpvfnciej4hHPkccmS2ccH9Q6nVogh+zYoRh
 zbN9nhQGSQNcB+elKheXPbaPHtspc/nAUMWerAjjAxlJ8PuoLqhB1C9sxPj6fcnGP6Pr12YJo
 Usb6z+B+Zekj3WE1RpqHO4zMFvQGAGFKi256GrFE04vMiQKh6k3pSlLwsmQ6RvgstPKHjNRDR
 OaZa+JzvwebQrAHwlm6XipVsVeccn8HgsaH74ITKnF/gaQbNHflCQmPxRfAZixta9IVROHJvV
 9OTqOKhZ6MYKsmXMmZUA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 7:57 AM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> The application processor accessing the dynamically assigned metadata
> region after assigning it to the remote Q6 would lead to an XPU violation.
> Fix this by un-mapping the metadata region post firmware header copy. The
> metadata region is freed only after the modem Q6 is done with fw header
> authentication.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry for the late reply, this looks reasonable overall. Just two
small comments:

>
> -       memcpy(ptr, metadata, size);
> +       count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +       pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> +       if (!pages) {
> +               ret = -ENOMEM;
> +               goto free_dma_attrs;
> +       }

If you know a fixed upper bound for the array size, it might be easier to
put it on the stack.

> +
> +       for (i = 0; i < count; i++)
> +               pages[i] = nth_page(page, i);
> +
> +       vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));

I was a bit unsure about this part, as I don't know how portable this is.
If the CPU bypasses the cache with pgprot_dmacoherent(), then the
other side should not use a cacheable access either, but that is a property
of the hardware that is normally hidden from the driver interface.

It's probably ok here, since the pages are not mapped anywhere else
and should have no active cache lines.

       Arnd
