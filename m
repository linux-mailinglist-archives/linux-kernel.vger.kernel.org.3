Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253A5144C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356127AbiD2Iur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356054AbiD2Ium (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:50:42 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D225AEF1;
        Fri, 29 Apr 2022 01:47:24 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id o11so5205606qtp.13;
        Fri, 29 Apr 2022 01:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sgYQJjr5iy1crCmQpq1/lmSUnF0hBfImD2gP+L9eDc=;
        b=4uY4ppyIdKDbDxNN7tTtmt8AlTB7kdlncJ6qQAuh1e5AcfDP/xKWMsqerhmKZ4bpZ9
         bjecum1pd5/QDGx42nbrymXH+3evwtgIXODUv1yB9t1eIwbJ1tzG7CrInF6g++Cgd2p7
         BBHGrE3bwm0uznLUhlWreJ4s4zIOLAioj5n6yuWNJBOALhApzfQgW2+XaARn+eD0rIR5
         cpPksRXB67S3yw0Zf+fomBXu7+Izr3b9Hr8naQKD+gdmdiDX2lzyEedxl8vM78363YX4
         gxqtL6GFoxeZt1RXv5FzMR+qU07Q7q0j9KjcqvDrjNrkoWV4vf9PrtcvnNvm4yoLg1QJ
         P8hw==
X-Gm-Message-State: AOAM532NJQZru6jGiEq8jP8qiOg3UsrmtNp8rV5bFi3xpXgI8RqwLnt3
        EcJaOlBqx8yjEDJE80zTfqvhzjyKG+Jzg3fS
X-Google-Smtp-Source: ABdhPJxsCBXW4jKd3h6bCRDYJ1tHvRExlFkV205y9J+SRhreYu+eDwv4UR+mhu53Nud44hJ9h8j8ZA==
X-Received: by 2002:ac8:4e86:0:b0:2f3:6a2f:ef75 with SMTP id 6-20020ac84e86000000b002f36a2fef75mr16651069qtp.588.1651222043093;
        Fri, 29 Apr 2022 01:47:23 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87318000000b002f1fc5fcaedsm1303607qto.68.2022.04.29.01.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:47:22 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f38so13339465ybi.3;
        Fri, 29 Apr 2022 01:47:21 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr35590406ybq.393.1651222041398; Fri, 29
 Apr 2022 01:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
In-Reply-To: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:47:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYJofetMwkAH4d8UzKZH77hxwRhXrMhaECOs1suQV2PA@mail.gmail.com>
Message-ID: <CAMuHMdWYJofetMwkAH4d8UzKZH77hxwRhXrMhaECOs1suQV2PA@mail.gmail.com>
Subject: Re: [v4 00/18] ASoC: mediatek: Add support for MT8186 SoC
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, aaronyu@google.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Julian Braha <julianbraha@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxin,

Gmail tends to mark your patches as spam.
Can you please make sure to use "PATCH" in the subject line, e.g.
"[PATCH v4 00/18] ASoC: mediatek: Add support for MT8186 SoC"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
