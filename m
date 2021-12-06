Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B497F468FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhLFDch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:32:37 -0500
Received: from mail-4022.proton.ch ([185.70.40.22]:10533 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhLFDcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:32:36 -0500
Date:   Mon, 06 Dec 2021 03:28:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alshehhi.io;
        s=protonmail2; t=1638761345;
        bh=LIilJepgRxOVtJaBcz40rYOX9viWp9D1ckVodYXjOJA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=C6yrOMLG4HOTVI8v9+T5ebhfRzayTMzdSG4nzp760uDgVQRIdzokgPjmOVzMmbJOc
         uxu94W6gn4br6XINwsjdKTRWPZWwbzJAVMD4+BgSPypWhTZozGexkT/GIax25lblIZ
         8HXX7roPni1P4UVFVfoIKJUspAirR0sFVnPv+UOdLMN8N3yu9DhbsxblMJ/xegvKGO
         LrFrw4rd1rlla/vUKYzXCcdnw3PDK2xTtE5j7uJaTX843XS3EcZkRWWpTbGDY/TVMJ
         wqcQcmtEU3dewYL26a+DfNSv3hlD7juMKlo+2uB9qVrdsgPARPKtPYp/wfwOCIv9qe
         WiXvwbutK64rg==
To:     masahiroy@kernel.org
From:   husain@alshehhi.io
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Husain Alshehhi <husain@alshehhi.io>
Reply-To: husain@alshehhi.io
Subject: [PATCH] Fix styling issues reported by checkpatch in usr/gen_init_cpio.c
Message-ID: <20211206032840.531625-1-husain@alshehhi.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Husain Alshehhi <husain@alshehhi.io>

Signed-off-by: Husain Alshehhi <husain@alshehhi.io>
---
 usr/gen_init_cpio.c | 177 +++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 86 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 0e2c8a5838b1..a419086f94f0 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -39,7 +39,7 @@ static void push_string(const char *name)
 =09offset +=3D name_len;
 }

-static void push_pad (void)
+static void push_pad(void)
 {
 =09while (offset & 3) {
 =09=09putchar(0);
@@ -77,20 +77,20 @@ static void cpio_trailer(void)

 =09sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 =09       "%08X%08X%08X%08X%08X%08X%08X",
-=09=09"070701",=09=09/* magic */
-=09=090,=09=09=09/* ino */
-=09=090,=09=09=09/* mode */
-=09=09(long) 0,=09=09/* uid */
-=09=09(long) 0,=09=09/* gid */
-=09=091,=09=09=09/* nlink */
-=09=09(long) 0,=09=09/* mtime */
-=09=090,=09=09=09/* filesize */
-=09=090,=09=09=09/* major */
-=09=090,=09=09=09/* minor */
-=09=090,=09=09=09/* rmajor */
-=09=090,=09=09=09/* rminor */
-=09=09(unsigned)strlen(name)+1, /* namesize */
-=09=090);=09=09=09/* chksum */
+=09=09"070701",=09=09=09/* magic */
+=09=090,=09=09=09=09/* ino */
+=09=090,=09=09=09=09/* mode */
+=09=090L,=09=09=09=09/* uid */
+=09=090L,=09=09=09=09/* gid */
+=09=091,=09=09=09=09/* nlink */
+=09=090L,=09=09=09=09/* mtime */
+=09=090,=09=09=09=09/* filesize */
+=09=090,=09=09=09=09/* major */
+=09=090,=09=09=09=09/* minor */
+=09=090,=09=09=09=09/* rmajor */
+=09=090,=09=09=09=09/* rminor */
+=09=09(unsigned int)strlen(name)+1,=09/* namesize */
+=09=090);=09=09=09=09/* chksum */
 =09push_hdr(s);
 =09push_rest(name);

@@ -107,22 +107,22 @@ static int cpio_mkslink(const char *name, const char =
*target,

 =09if (name[0] =3D=3D '/')
 =09=09name++;
-=09sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+=09sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 =09       "%08X%08X%08X%08X%08X%08X%08X",
-=09=09"070701",=09=09/* magic */
-=09=09ino++,=09=09=09/* ino */
-=09=09S_IFLNK | mode,=09=09/* mode */
-=09=09(long) uid,=09=09/* uid */
-=09=09(long) gid,=09=09/* gid */
-=09=091,=09=09=09/* nlink */
-=09=09(long) default_mtime,=09/* mtime */
-=09=09(unsigned)strlen(target)+1, /* filesize */
-=09=093,=09=09=09/* major */
-=09=091,=09=09=09/* minor */
-=09=090,=09=09=09/* rmajor */
-=09=090,=09=09=09/* rminor */
-=09=09(unsigned)strlen(name) + 1,/* namesize */
-=09=090);=09=09=09/* chksum */
+=09=09"070701",=09=09=09/* magic */
+=09=09ino++,=09=09=09=09/* ino */
+=09=09S_IFLNK | mode,=09=09=09/* mode */
+=09=09(long) uid,=09=09=09/* uid */
+=09=09(long) gid,=09=09=09/* gid */
+=09=091,=09=09=09=09/* nlink */
+=09=09(long) default_mtime,=09=09/* mtime */
+=09=09(unsigned int)strlen(target)+1,=09/* filesize */
+=09=093,=09=09=09=09/* major */
+=09=091,=09=09=09=09/* minor */
+=09=090,=09=09=09=09/* rmajor */
+=09=090,=09=09=09=09/* rminor */
+=09=09(unsigned int)strlen(name) + 1,=09/* namesize */
+=09=090);=09=09=09=09/* chksum */
 =09push_hdr(s);
 =09push_string(name);
 =09push_pad();
@@ -140,7 +140,7 @@ static int cpio_mkslink_line(const char *line)
 =09int gid;
 =09int rc =3D -1;

-=09if (5 !=3D sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d =
%d", name, target, &mode, &uid, &gid)) {
+=09if (sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", na=
me, target, &mode, &uid, &gid) !=3D 5) {
 =09=09fprintf(stderr, "Unrecognized dir format '%s'", line);
 =09=09goto fail;
 =09}
@@ -156,22 +156,22 @@ static int cpio_mkgeneric(const char *name, unsigned =
int mode,

 =09if (name[0] =3D=3D '/')
 =09=09name++;
-=09sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+=09sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 =09       "%08X%08X%08X%08X%08X%08X%08X",
-=09=09"070701",=09=09/* magic */
-=09=09ino++,=09=09=09/* ino */
-=09=09mode,=09=09=09/* mode */
-=09=09(long) uid,=09=09/* uid */
-=09=09(long) gid,=09=09/* gid */
-=09=092,=09=09=09/* nlink */
-=09=09(long) default_mtime,=09/* mtime */
-=09=090,=09=09=09/* filesize */
-=09=093,=09=09=09/* major */
-=09=091,=09=09=09/* minor */
-=09=090,=09=09=09/* rmajor */
-=09=090,=09=09=09/* rminor */
-=09=09(unsigned)strlen(name) + 1,/* namesize */
-=09=090);=09=09=09/* chksum */
+=09=09"070701",=09=09=09/* magic */
+=09=09ino++,=09=09=09=09/* ino */
+=09=09mode,=09=09=09=09/* mode */
+=09=09(long) uid,=09=09=09/* uid */
+=09=09(long) gid,=09=09=09/* gid */
+=09=092,=09=09=09=09/* nlink */
+=09=09(long) default_mtime,=09=09/* mtime */
+=09=090,=09=09=09=09/* filesize */
+=09=093,=09=09=09=09/* major */
+=09=091,=09=09=09=09/* minor */
+=09=090,=09=09=09=09/* rmajor */
+=09=090,=09=09=09=09/* rminor */
+=09=09(unsigned int)strlen(name) + 1,=09/* namesize */
+=09=090);=09=09=09=09/* chksum */
 =09push_hdr(s);
 =09push_rest(name);
 =09return 0;
@@ -211,7 +211,7 @@ static int cpio_mkgeneric_line(const char *line, enum g=
eneric_types gt)
 =09int gid;
 =09int rc =3D -1;

-=09if (4 !=3D sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &u=
id, &gid)) {
+=09if (sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gi=
d) !=3D 4) {
 =09=09fprintf(stderr, "Unrecognized %s format '%s'",
 =09=09=09line, generic_type_table[gt].type);
 =09=09goto fail;
@@ -250,22 +250,22 @@ static int cpio_mknod(const char *name, unsigned int =
mode,

 =09if (name[0] =3D=3D '/')
 =09=09name++;
-=09sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+=09sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 =09       "%08X%08X%08X%08X%08X%08X%08X",
-=09=09"070701",=09=09/* magic */
-=09=09ino++,=09=09=09/* ino */
-=09=09mode,=09=09=09/* mode */
-=09=09(long) uid,=09=09/* uid */
-=09=09(long) gid,=09=09/* gid */
-=09=091,=09=09=09/* nlink */
-=09=09(long) default_mtime,=09/* mtime */
-=09=090,=09=09=09/* filesize */
-=09=093,=09=09=09/* major */
-=09=091,=09=09=09/* minor */
-=09=09maj,=09=09=09/* rmajor */
-=09=09min,=09=09=09/* rminor */
-=09=09(unsigned)strlen(name) + 1,/* namesize */
-=09=090);=09=09=09/* chksum */
+=09=09"070701",=09=09=09/* magic */
+=09=09ino++,=09=09=09=09/* ino */
+=09=09mode,=09=09=09=09/* mode */
+=09=09(long) uid,=09=09=09/* uid */
+=09=09(long) gid,=09=09=09/* gid */
+=09=091,=09=09=09=09/* nlink */
+=09=09(long) default_mtime,=09=09/* mtime */
+=09=090,=09=09=09=09/* filesize */
+=09=093,=09=09=09=09/* major */
+=09=091,=09=09=09=09/* minor */
+=09=09maj,=09=09=09=09/* rmajor */
+=09=09min,=09=09=09=09/* rminor */
+=09=09(unsigned int)strlen(name) + 1,=09/* namesize */
+=09=090);=09=09=09=09/* chksum */
 =09push_hdr(s);
 =09push_rest(name);
 =09return 0;
@@ -282,8 +282,8 @@ static int cpio_mknod_line(const char *line)
 =09unsigned int min;
 =09int rc =3D -1;

-=09if (7 !=3D sscanf(line, "%" str(PATH_MAX) "s %o %d %d %c %u %u",
-=09=09=09 name, &mode, &uid, &gid, &dev_type, &maj, &min)) {
+=09if (sscanf(line, "%" str(PATH_MAX) "s %o %d %d %c %u %u",
+=09=09=09 name, &mode, &uid, &gid, &dev_type, &maj, &min) !=3D 7) {
 =09=09fprintf(stderr, "Unrecognized nod format '%s'", line);
 =09=09goto fail;
 =09}
@@ -308,9 +308,9 @@ static int cpio_mkfile(const char *name, const char *lo=
cation,

 =09mode |=3D S_IFREG;

-=09file =3D open (location, O_RDONLY);
+=09file =3D open(location, O_RDONLY);
 =09if (file < 0) {
-=09=09fprintf (stderr, "File %s could not be opened for reading\n", locati=
on);
+=09=09fprintf(stderr, "File %s could not be opened for reading\n", locatio=
n);
 =09=09goto error;
 =09}

@@ -328,25 +328,26 @@ static int cpio_mkfile(const char *name, const char *=
location,

 =09filebuf =3D malloc(buf.st_size);
 =09if (!filebuf) {
-=09=09fprintf (stderr, "out of memory\n");
+=09=09fprintf(stderr, "out of memory\n");
 =09=09goto error;
 =09}

-=09retval =3D read (file, filebuf, buf.st_size);
+=09retval =3D read(file, filebuf, buf.st_size);
 =09if (retval < 0) {
-=09=09fprintf (stderr, "Can not read %s file\n", location);
+=09=09fprintf(stderr, "Can not read %s file\n", location);
 =09=09goto error;
 =09}

 =09size =3D 0;
 =09for (i =3D 1; i <=3D nlinks; i++) {
 =09=09/* data goes on last link */
-=09=09if (i =3D=3D nlinks) size =3D buf.st_size;
+=09=09if (i =3D=3D nlinks)
+=09=09=09size =3D buf.st_size;

 =09=09if (name[0] =3D=3D '/')
 =09=09=09name++;
 =09=09namesize =3D strlen(name) + 1;
-=09=09sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+=09=09sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 =09=09       "%08lX%08X%08X%08X%08X%08X%08X",
 =09=09=09"070701",=09=09/* magic */
 =09=09=09ino,=09=09=09/* ino */
@@ -379,10 +380,12 @@ static int cpio_mkfile(const char *name, const char *=
location,
 =09}
 =09ino++;
 =09rc =3D 0;
-
+
 error:
-=09if (filebuf) free(filebuf);
-=09if (file >=3D 0) close(file);
+=09if (filebuf)
+=09=09free(filebuf);
+=09if (file >=3D 0)
+=09=09close(file);
 =09return rc;
 }

@@ -395,7 +398,7 @@ static char *cpio_replace_env(char *new_location)
 =09       (end =3D strchr(start + 2, '}'))) {
 =09=09*start =3D *end =3D 0;
 =09=09var =3D getenv(start + 2);
-=09=09snprintf(expanded, sizeof expanded, "%s%s%s",
+=09=09snprintf(expanded, sizeof(expanded), "%s%s%s",
 =09=09=09 new_location, var ? var : "", end + 1);
 =09=09strcpy(new_location, expanded);
 =09}
@@ -415,9 +418,9 @@ static int cpio_mkfile_line(const char *line)
 =09int end =3D 0, dname_len =3D 0;
 =09int rc =3D -1;

-=09if (5 > sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX)
-=09=09=09=09"s %o %d %d %n",
-=09=09=09=09name, location, &mode, &uid, &gid, &end)) {
+=09if (sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX)
+=09=09=09"s %o %d %d %n",
+=09=09=09name, location, &mode, &uid, &gid, &end) < 5) {
 =09=09fprintf(stderr, "Unrecognized file format '%s'", line);
 =09=09goto fail;
 =09}
@@ -427,7 +430,7 @@ static int cpio_mkfile_line(const char *line)

 =09=09dname =3D malloc(strlen(line));
 =09=09if (!dname) {
-=09=09=09fprintf (stderr, "out of memory (%d)\n", dname_len);
+=09=09=09fprintf(stderr, "out of memory (%d)\n", dname_len);
 =09=09=09goto fail;
 =09=09}

@@ -449,9 +452,10 @@ static int cpio_mkfile_line(const char *line)
 =09=09dname =3D name;
 =09}
 =09rc =3D cpio_mkfile(dname, cpio_replace_env(location),
-=09                 mode, uid, gid, nlinks);
+=09=09=09 mode, uid, gid, nlinks);
  fail:
-=09if (dname_len) free(dname);
+=09if (dname_len)
+=09=09free(dname);
 =09return rc;
 }

@@ -524,7 +528,7 @@ static const struct file_handler file_handler_table[] =
=3D {

 #define LINE_SIZE (2 * PATH_MAX + 50)

-int main (int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 =09FILE *cpio_list;
 =09char line[LINE_SIZE];
@@ -592,7 +596,7 @@ int main (int argc, char *argv[])
 =09=09=09continue;
 =09=09}

-=09=09if (! (type =3D strtok(line, " \t"))) {
+=09=09if (!(type =3D strtok(line, " \t"))) {
 =09=09=09fprintf(stderr,
 =09=09=09=09"ERROR: incorrect format, could not locate file type line %d: =
'%s'\n",
 =09=09=09=09line_nr, line);
@@ -610,7 +614,7 @@ int main (int argc, char *argv[])
 =09=09=09continue;
 =09=09}

-=09=09if (! (args =3D strtok(NULL, "\n"))) {
+=09=09if (!(args =3D strtok(NULL, "\n"))) {
 =09=09=09fprintf(stderr,
 =09=09=09=09"ERROR: incorrect format, newline required line %d: '%s'\n",
 =09=09=09=09line_nr, line);
@@ -619,7 +623,8 @@ int main (int argc, char *argv[])

 =09=09for (type_idx =3D 0; file_handler_table[type_idx].type; type_idx++) =
{
 =09=09=09int rc;
-=09=09=09if (! strcmp(line, file_handler_table[type_idx].type)) {
+
+=09=09=09if (!strcmp(line, file_handler_table[type_idx].type)) {
 =09=09=09=09if ((rc =3D file_handler_table[type_idx].handler(args))) {
 =09=09=09=09=09ec =3D rc;
 =09=09=09=09=09fprintf(stderr, " line %d\n", line_nr);
@@ -628,7 +633,7 @@ int main (int argc, char *argv[])
 =09=09=09}
 =09=09}

-=09=09if (NULL =3D=3D file_handler_table[type_idx].type) {
+=09=09if (file_handler_table[type_idx].type =3D=3D NULL) {
 =09=09=09fprintf(stderr, "unknown file type line %d: '%s'\n",
 =09=09=09=09line_nr, line);
 =09=09}
--
2.25.1


