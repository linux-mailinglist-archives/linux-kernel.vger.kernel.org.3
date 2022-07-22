Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7557E1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiGVMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiGVMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:55:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9EB30
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:55:06 -0700 (PDT)
Received: from mail-oa1-f46.google.com ([209.85.160.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mn2iP-1npBvz1zqZ-00k5Bk for <linux-kernel@vger.kernel.org>; Fri, 22 Jul
 2022 14:55:04 +0200
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f2a4c51c45so6178334fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:55:04 -0700 (PDT)
X-Gm-Message-State: AJIora+8IWEBZNKKxJP3s2OVjPcOWZU05yQi3EEWtbHEx+9IelGXGGHB
        gJyK0047ZkWJIKNoDUXqHupD6npgiFN36te6pI8=
X-Google-Smtp-Source: AGRyM1s+iHLsdgkmdkk4di9JAvPFlgedmxCorRD0IrEiusEfRXpDLrfbD9o9bDG8BEGMUnK4YNuB/edDIjYtpGCtBc4=
X-Received: by 2002:a05:6870:6114:b0:10c:6bf:542f with SMTP id
 s20-20020a056870611400b0010c06bf542fmr7496047oae.188.1658494503231; Fri, 22
 Jul 2022 05:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220722103158.82218-1-slark_xiao@163.com>
In-Reply-To: <20220722103158.82218-1-slark_xiao@163.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 14:54:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07wAc5iv4eBaixPQiGhdDur=9p-Dpb4Kh4MdqUkAkeww@mail.gmail.com>
Message-ID: <CAK8P3a07wAc5iv4eBaixPQiGhdDur=9p-Dpb4Kh4MdqUkAkeww@mail.gmail.com>
Subject: Re: [PATCH] uapi: asm-generic: fcntl: Fix typo 'the the' in comment
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kmih5KotRui0dMoWIXig0tHA4lshsBJfGkbKlX8vkspOotByzQY
 VXrW2qa+/B/e60l17E6IdIAuojxDuln9SoH86Vv2jkEcxuRxT7q26NMwunP4Zklkt7yEXRa
 R0mO/xRcdUoUfKekAwWuft46KGU7SBTcQo7qoL0kBjh/MlBgbqhhuv2k6KVrY1iBlM8OIaC
 ntHbe8TchSLB8KJHIjvlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rs3pBeOAs6c=:4eIeyH4AaFP2XO1AWNrAjs
 mwK0zlDgrRcvKmNxSWuM7KNnLwDj86y6y0AhqKdUp1BAjlRUx2HfrpypMDvJiOoQgnt5gSbEw
 AUex3fDrxrhWS16Zo4J9QB4U0ETRyqb9Jffo0JhnWCAgcCiryoM18NdJFduuROehKAkoyEB3o
 im1nAlOnbe6pjG1IadVM/rUa/wZjlaY9nxeY4BjKe4z5AsClWVSA16V+8M9v87mphidvdiYuA
 ojVyfZD3sLWWYJ6HOIeMOaJu/5dS/gxWgaW9mxL6WU4O+niVur9+n62E+e4Gf9r6hh0Q86hWr
 d3KZoIxWAPjlik5kVhB+aeuux4wpn2gMzTe+Td8i08PWFQXAaMq5hqk5pgaF17ncwAy4Q7N3P
 0/cDiwtOLFday88/+XXuGQChwobDv51j44rII5VqtdBlMITruBSsUaXfxosv2XYmUkNykopcg
 Gtkfsep9VBR/xAwFMjBNrxWsKUHCjeyd4sCJ460Mn/qp+aVWqMg7k1nBgdkx63ky9dbNi06Ts
 TcIF6ePBnBihjquWxlHDZzCKRtgDrEvvu4VgXfWy7wVqd25pY01Y9d1lXh7gaQ2S5OgfKO4bW
 TvTtC7689jfEyHIfDEgk5zjW9ZVpOun44PWLs/o1pf0W58izrJLAqu7NB0BrhcTBNY39D9OUC
 wgJjTJQ4MBuGiT8+50kk2QyHVSg+wRQ/HxIQegor4hPRgng6V57wTomLMpmAs4DE7GuIY+hKz
 sxYaLg5SRzr1G/XZwaJE7Ma4j3cY/8nhTUiphEK5WJaNn87Gq85o9fW6mr5JNLwA0SHpzWwNd
 /g5L9JXAdO0MRb+NLjnaYPUCCEepwvy182MsN4g6YqsTTVCFn85aViclXxOsFzbBTBX9bCdk6
 WqRIgwjzToyC5QJqz4vA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:31 PM Slark Xiao <slark_xiao@163.com> wrote:
>
> Replace 'the the' with 'the' in the comment.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to the asm-generic tree, thanks!

      Arnd
