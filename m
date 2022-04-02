Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E04F04AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357554AbiDBP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiDBP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:59:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69E6007D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:57:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s11so4513865qtc.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5+kfbZqaslK8/sN6sec2xsR8jaOvugDdGWVch0NWoo=;
        b=U9eLHOULpquZmknHxDfjIDdBHKBZ7TcCdS4EQceWSfv3//aKGCYKcKZLpth7GzNSp5
         v2M73PZ3j9Wb2csPbX5k+TxEmWvPw0MbPPJZMaDFUNxtkCY7rEXtAev80uovs7LZfcZn
         Tfo4P5DqdbiT32xd12LCBdmL81bNdd/t/esS/tH/Wm/y29XDfMLlKAUoqYxWz+8hYMtG
         LP9OdK6DowesNlM6axaEx9J8ExqWIlhDjsoVW28q9xNWC2VXDyoyWBWVFE6MI/xogSZX
         Pcg4N6Vu7hAxmQZKLfUwB+xYTj8V29Hs72Jf44xD3DlauJHz6h7/5CaUubYXvxsOANQQ
         YrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5+kfbZqaslK8/sN6sec2xsR8jaOvugDdGWVch0NWoo=;
        b=LpqXk14mhJ4H5F2v41zMfCAm9OOPi27jDFEBOQl3/UeIkd3SXDljYNlkH7ogDCmX5l
         MIzBga+y5nBsUt0O3NbLK5b7ttXtI3E6nXZA2txq2oXRxjrYBtlOATe0sML0XurZT9pu
         EWG3n11GOiyOU48+ybhDInsOIV5xoW2YEBxjyb4cBG4uI9Sk0tDRizZbtl+TpCoq8mQB
         wZIH3oHQ5PpJ5EK2UNbQCtIyGWBi29LABDtFAc8qZLBdmbUvKKvyxsZomde64fPwHBhS
         rHk8gEdJmnW65SIY9W3plp99TY4x+k3B4ZhsguXKzkO5DV08dwwEuY9OZnbrTKh1o5i+
         FfMQ==
X-Gm-Message-State: AOAM530cdVQM30Mno5kNQ8iiUG+z4cP1vF0HkQA4hn40i8MW0LBa6WtR
        +ulRdgTU52Xuhr/+keaT9qofktjkSLXEpejUU60F/g==
X-Google-Smtp-Source: ABdhPJxXUpYXZgtI9LT+t52q7oaFVmVo/htvwqeg6rYPBeFv0HxAzYU98tlLqzfxcFlXUAW4cTq9SAlo3bDK59U0U3s=
X-Received: by 2002:ac8:578a:0:b0:2e1:a0d2:c3a with SMTP id
 v10-20020ac8578a000000b002e1a0d20c3amr12151172qta.261.1648915072211; Sat, 02
 Apr 2022 08:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
 <10c1e561-8f01-784f-c4f4-a7c551de0644@uls.co.za> <CADVnQynf8f7SUtZ8iQi-fACYLpAyLqDKQVYKN-mkEgVtFUTVXQ@mail.gmail.com>
 <e0bc0c7f-5e47-ddb7-8e24-ad5fb750e876@uls.co.za> <CANn89i+Dqtrm-7oW+D6EY+nVPhRH07GXzDXt93WgzxZ1y9_tJA@mail.gmail.com>
 <CADVnQyn=VfcqGgWXO_9h6QTkMn5ZxPbNRTnMFAxwQzKpMRvH3A@mail.gmail.com>
 <5f1bbeb2-efe4-0b10-bc76-37eff30ea905@uls.co.za> <CADVnQymPoyY+AX_P7k+NcRWabJZrb7UCJdDZ=FOkvWguiTPVyQ@mail.gmail.com>
 <CADVnQy=GX0J_QbMJXogGzPwD=f0diKDDxLiHV0gzrb4bo=4FjA@mail.gmail.com>
 <429dd56b-8a6c-518f-ccb4-fa5beae30953@uls.co.za> <20220402141410.GE28321@breakpoint.cc>
In-Reply-To: <20220402141410.GE28321@breakpoint.cc>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sat, 2 Apr 2022 11:57:36 -0400
Message-ID: <CADVnQymVpNP+=K=fYV2yub0DfVRHJ0tQskS7fY8KUun8HZiHAA@mail.gmail.com>
Subject: Re: linux 5.17.1 disregarding ACK values resulting in stalled TCP connections
To:     Florian Westphal <fw@strlen.de>
Cc:     Jaco Kroon <jaco@uls.co.za>, Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 10:14 AM Florian Westphal <fw@strlen.de> wrote:
>
> Jaco Kroon <jaco@uls.co.za> wrote:
> > Including sysctl net.netfilter.nf_conntrack_log_invalid=6- which
> > generates lots of logs, something specific I should be looking for?  I
> > suspect these relate:
> >
> > [Sat Apr  2 10:31:53 2022] nf_ct_proto_6: SEQ is over the upper bound
> > (over the window of the receiver) IN= OUT=bond0
> > SRC=2c0f:f720:0000:0003:d6ae:52ff:feb8:f27b
> > DST=2a00:1450:400c:0c08:0000:0000:0000:001a LEN=2928 TC=0 HOPLIMIT=64
> > FLOWLBL=867133 PROTO=TCP SPT=48920 DPT=25 SEQ=2689938314 ACK=4200412020
> > WINDOW=447 RES=0x00 ACK PSH URGP=0 OPT (0101080A2F36C1C120EDFB91) UID=8
> > GID=12
>
> I thought this had "liberal mode" enabled for tcp conntrack?
> The above implies its off.

Jaco's email said: "Our core firewalls already had
nf_conntrack_tcp_be_liberal". But this log is from the client machine
itself, not the core firewall machines. AFAICT it seems the client
machine does not have "liberal mode" enabled.

neal
