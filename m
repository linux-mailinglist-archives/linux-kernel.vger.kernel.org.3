Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871E587DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiHBN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiHBN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:56:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC52B19C;
        Tue,  2 Aug 2022 06:55:49 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0X4c-1nXnV92TEC-00wRfU; Tue, 02 Aug 2022 15:55:47 +0200
Received: by mail-ej1-f43.google.com with SMTP id j8so840639ejx.9;
        Tue, 02 Aug 2022 06:55:47 -0700 (PDT)
X-Gm-Message-State: AJIora8YtmpPlbFH9Jhq5al2EUyulVRNRiffVLDFSM7/KOi5k8PiOjFz
        6kZ31c90YttYonYn9xkXBni5cqO8rTJuO3lPAf8=
X-Google-Smtp-Source: AGRyM1sg5OSSuxk42kmKffHKNvxjUBcwJeG8BNdRHNFKc4WmLSSYCEYhA87Rt2osXHOB56kfJ3SZKbK9oZESz3OQKdY=
X-Received: by 2002:a17:907:d0f:b0:72e:db1f:9b91 with SMTP id
 gn15-20020a1709070d0f00b0072edb1f9b91mr16334680ejc.470.1659448547198; Tue, 02
 Aug 2022 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com>
 <0a0a64a7-60cc-e95d-c2e3-3c11a53a6527@socionext.com> <CAK8P3a0egd9dupLFid9CsSygQyTK3KopB8m5LVgnUW9L1cF6JA@mail.gmail.com>
 <fd6e9539-4c67-93a2-9104-018ed9703ff9@socionext.com>
In-Reply-To: <fd6e9539-4c67-93a2-9104-018ed9703ff9@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Aug 2022 15:55:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2sFYvopsuNqZ5uTFNbgV+t_8ZtWVR6ziCHk7p2eRy5LA@mail.gmail.com>
Message-ID: <CAK8P3a2sFYvopsuNqZ5uTFNbgV+t_8ZtWVR6ziCHk7p2eRy5LA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Update UniPhier armv8 devicetree
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nxeck6+fKHfSgr0GQyASw/Fv+tmX23a9v7NOMLbgHvgrjPDXjBU
 wzQ04UkwRBR4FvCb2nFsp2aU8zy6F080hX4uMIWzDqq958Fq5FzrfAONZ1Nfo8Ee3rjrxlp
 hDq/tM2a4v3qcsNgLbVq0wwLkqFlyLBuixpO2M6r+mTEIVF3FTIwwfezsVQH1BJQb4jtm0l
 J5tIxs8MRQr7/HsOyqGHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W+bxOYNdzvA=:IQ9NBZqgLGkkMHKcdmV7UX
 us9vGLw0XTP24WI+fjxvzvjqqkM3ZI1eDwpSyrM+lG0s7CpSmtNhawQbmPy/oE2xs5MChXoUI
 p7/GpTTizg0PCAkhPiWKIF1mCMSQocNH9E8f/hoqauszJ96cc4fflBjplNMfaHbIo4SrrpLX4
 LCp0KlZN8u1H3d1JOlQsrLb8T/ZzM+p5Rf5gVEuExRXMu9kcbXPn9oFO39az19s/bH6Z4o0z7
 /0nLaa3TuHoLv220DTHsDO28qrvNq064Si4quKrbTh5Qv+aK4v5IQ+7ocU9YUzDds+Skifclo
 pvjo2qIgQ9upkxwO+pOZ46Uf48y50CDj28bAsMfm3qX1bHGV7qh0o+YowjbYkibFY26YyKazI
 2yyVNkieguxYrUuEp5KS4dfB1yBh9SE2yeUF/fDLSTKtZ9iB+nyonSedR90bpDFUV+k6+ERFr
 eIQpK6QGJvpdJzSsa0m44wv515+eIU4l9ZW6CaEcif7q/nbbM18au689rd7gx6uc9yAGE8xkR
 9UnH3LTfppkji3Pz52r/SsU36/sFkgcSN4DQl8fNL9OgNNAzoUEOi5LyLQAwOFRripfQt16iR
 H42oZglQofvAuEvfxg/9dFDK6FD7HTBGE0i4QxyfO5fflkltUF4IP8/66o7G0L1t1wqaep3T/
 IZSQV32pS6Ia7HXBojPh8A3q4uAcyoFe0/YQYnXUqTx/jtp3llV3tbszYIlrOoxJXQYaRcf9w
 HR+AI9k1vje4OciR0DvTHNll0RDgU5d6AncZIg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:24 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> > A lot of the changes can be considered bugfixes, and I would still
> > merge them if you
> > think they are harmless and can fix things. In this case, also mark them as
> > 'Cc: stable@vger.kernel.org' to be backported into lts kernels. Anything
> > that
> > does not qualify as a bugfix should now go into the 5.21 merge window.
> >
> > Please send the bugfix pull request as soon as you can so we can merge that
> > early. The other updates should be rebased onto v5.20-rc1 once that is
> > released in about two weeks.
>
> There are one bugfix patch for each series and they will be sent for "stable".
> About the other patches, I'll rebase and send them again.

Ok, I picked up the two patches you just sent. Please make sure in the future to
send all pull requests and patches that you want me to pick up to soc@kernel.org
(Cc the usual lists) so they end up in patchwork and do not get lost.

       Arnd
