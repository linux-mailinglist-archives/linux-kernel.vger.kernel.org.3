Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD54C70E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiB1Pny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiB1Pnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:43:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286F27162
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:43:10 -0800 (PST)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOzfO-1nYXxY2tVE-00PO9L for <linux-kernel@vger.kernel.org>; Mon, 28 Feb
 2022 16:43:08 +0100
Received: by mail-wr1-f46.google.com with SMTP id r10so16139277wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:43:08 -0800 (PST)
X-Gm-Message-State: AOAM531SSeduorH/zxKn7/byS+caLnPr/iMl0tIk7QG3IWS5TnQI/Gsm
        UBgccNc+Lc1sNpRayhpggI+NbYE0/evhNs4p8Q0=
X-Google-Smtp-Source: ABdhPJxy9c35EGGAS0iifgxjfOaWuz+Cg9Pw2HqEn7LFPLaX1taoWlH9BAHwhP/QqUpTqblafUJ9zpUAXON7IXLX19E=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr16234935wri.219.1646062988362; Mon, 28
 Feb 2022 07:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20220226124826.1564871-1-mail@conchuod.ie>
In-Reply-To: <20220226124826.1564871-1-mail@conchuod.ie>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 16:42:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2y2j=zSsPtAFDZxv9b_e2SG6V5DBy__voiHRnDw5n4Aw@mail.gmail.com>
Message-ID: <CAK8P3a2y2j=zSsPtAFDZxv9b_e2SG6V5DBy__voiHRnDw5n4Aw@mail.gmail.com>
Subject: Re: [PATCH] soc: microchip: make mpfs_sys_controller_put static
To:     Conor Dooley <mail@conchuod.ie>
Cc:     conor.dooley@microchip.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VnEZVw0offLdINVVEeiEBePob+PrWElG+2FgEla6SI7XwfxtzAK
 D532ierdcPqqNkq69dWDXB0u/DPuuqD1R2wiCpV4e/PzqpdWb2i6cgyo9f2Ai6tJmHB92TN
 o9wvefPz6TzbY+SryjpVe26fZXSjceEJ1FjtAc+ysNlMckbEw7x8w7T5jZO4W9WGZgmSxAj
 bFrx3+B+hRf+Klegl/bAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmYRt1Wklbo=:gvA6TfUWaKqhoDbr10zjUK
 2rNZ+yeowrIfjG1iXM3pRjQ+0mNVuIVWvVMgtHNiKd4h31o49v8eW5UHPls/jlBJAC0WrRcLx
 qxMTIJGGofTDEVStaGgNhT5qfbWqFBXhHFIO5FQXpHbAm5RHcG9ykRSct2Dr+2x54EjZSG7Ea
 9DAOlx77SZ3VpZojt3JuEPvbna9C6fWC7ITlKGaigWOevGvy2XfH5Piv4dEh0fX3FbE1K4neA
 oQmQulpZ77dK8It/Ngcgyut0Mu9ouqrTIek+/EC6eyO32r9vGMRIlWPOEFwQkZUQfuX9Zhxtu
 QkzZFJ94LXRAh6PxTqRievQHhCxoMb/xmNMBZeAV0DfLkoQzpWn7Pe115XfLcam97mJlIQAv9
 AlhZrq4HxRhHOV/u24Dc2VkLnqWApSZMZnH+OaapzelC/9PNa0O/Yg62Y5Y7pyIU+v28J1nVV
 AZasstk7poiNZDb3BGuISx6HOvcPXx56DxmAMpe17o4hOP+gi9POEM7RANXF/DgsLEhjObYTK
 vUomoBNXtdaSflaMKTbnbhVv4CXFWcLYNyE+D0tCEyT0oUaVPAr7+CiSmN6fXNU/dHfbLWidO
 bKfAGhvdNFJBqvuS5m53Y4Rf+2tvjMzi5Blch6TSW0aHLQ6K292SwwN2j5fWjsrN/yC+jaCSJ
 gXtwRgo6RQZn9WBdhLGr+/MwFZJhjYKvDZlynU5ZedYJ60SnLEc0oetCBoaCOt+Ch5y0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 1:48 PM Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> dsafsdfd0054 ("soc: add microchip polarfire soc system controller")
> incorrectly exported mpfs_sys_controller_put. Remove the export and make
> the function static instead. This fixes the "no previous prototype
> for 'mpfs_sys_controller_put'" warning spotted by the kernel test robot.
>
> Fixes: dsafsdfd0054 ("soc: add microchip polarfire soc system
> controller")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <mail@conchuod.ie>

For reference, I saw the same report and added a different fix for  this
at first, but replaced it with this patch now. No need to add it to the at91
tree. Nicolas, in case there is another problem with this patch, let me know.

       Arnd
